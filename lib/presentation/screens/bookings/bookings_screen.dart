import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../data/models/booking.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/booking_provider.dart';
import '../../../providers/car_provider.dart';
import '../../widgets/common/async_value_widget.dart';
import '../../widgets/common/confirm_dialog.dart';
import '../../widgets/common/page_header.dart';
import '../../widgets/common/friendly_empty_state.dart';
import '../../../data/api/booking_api.dart';

class BookingsScreen extends ConsumerStatefulWidget {
  const BookingsScreen({super.key});

  @override
  ConsumerState<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends ConsumerState<BookingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final carId = ref.watch(selectedCarIdProvider);
    final l10n = AppLocalizations.of(context)!;

    if (carId == null) {
      return Center(child: Text(l10n.noCarSelected));
    }

    final bookingsAsync = ref.watch(bookingsProvider(carId));

    return Scaffold(
      body: Column(
        children: [
          PageHeader(icon: Icons.calendar_month_outlined, title: l10n.bookingsTitle),
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(icon: const Icon(Icons.calendar_month), text: l10n.bookingsCalendar),
              Tab(icon: const Icon(Icons.list), text: l10n.bookingsList),
            ],
          ),
          Expanded(
            child: AsyncValueWidget(
              value: bookingsAsync,
              data: (collection) {
                final bookings = collection.members;
                return TabBarView(
                  controller: _tabController,
                  children: [
                    _CalendarTab(
                      bookings: bookings,
                      focusedDay: _focusedDay,
                      selectedDay: _selectedDay,
                      onDaySelected: (selected, focused) {
                        setState(() {
                          _selectedDay = selected;
                          _focusedDay = focused;
                        });
                      },
                    ),
                    _ListTab(bookings: bookings, carId: carId),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/bookings/new'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _CalendarTab extends StatelessWidget {
  const _CalendarTab({
    required this.bookings,
    required this.focusedDay,
    required this.selectedDay,
    required this.onDaySelected,
  });

  final List<Booking> bookings;
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final void Function(DateTime, DateTime) onDaySelected;

  List<Booking> _eventsForDay(DateTime day) {
    return bookings.where((b) {
      return (b.startTime.isBefore(day.add(const Duration(days: 1))) &&
          b.endTime.isAfter(day));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar<Booking>(
          firstDay: DateTime.utc(2020),
          lastDay: DateTime.utc(2030),
          focusedDay: focusedDay,
          selectedDayPredicate: (day) => isSameDay(selectedDay, day),
          eventLoader: _eventsForDay,
          onDaySelected: onDaySelected,
          calendarStyle: const CalendarStyle(
            markerDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
        ),
        if (selectedDay != null) ...[
          const Divider(),
          Expanded(
            child: ListView(
              children: _eventsForDay(selectedDay!).map((b) {
                return ListTile(
                  title: Text(b.purpose ?? 'Booking'),
                  subtitle: Text(
                    '${DateFormat.Hm().format(b.startTime)} – '
                    '${DateFormat.Hm().format(b.endTime)}',
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ],
    );
  }
}

class _ListTab extends ConsumerWidget {
  const _ListTab({required this.bookings, required this.carId});

  final List<Booking> bookings;
  final int carId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    if (bookings.isEmpty) {
      return FriendlyEmptyState(
        icon: Icons.calendar_month_outlined,
        title: l10n.noBookings,
        actionLabel: l10n.newBooking,
        onAction: () => context.push('/bookings/new'),
      );
    }
    final locale = Localizations.localeOf(context).toString();
    final fmt = DateFormat.MMMd(locale).add_Hm();
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 96),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final b = bookings[index];
        return ListTile(
          title: Text(b.purpose ?? 'Booking by ${b.user?.name ?? 'Unknown'}'),
          subtitle: Text('${fmt.format(b.startTime)} – ${fmt.format(b.endTime)}'),
          trailing: IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => context.push('/bookings/${b.id}/edit'),
          ),
          onLongPress: () async {
            final confirmed = await showConfirmDialog(
              context,
              title: l10n.deleteBooking,
              message: l10n.deleteBookingConfirm,
              confirmLabel: l10n.delete,
            );
            if (confirmed) {
              await ref.read(bookingApiProvider).deleteBooking(b.id);
              ref.invalidate(bookingsProvider(carId));
            }
          },
        );
      },
    );
  }
}
