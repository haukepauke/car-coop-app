import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../data/api/trip_api.dart';
import '../../../data/models/trip.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/car_provider.dart';
import '../../../providers/trip_provider.dart';
import '../../widgets/common/async_value_widget.dart';
import '../../widgets/common/confirm_dialog.dart';
import '../../widgets/common/friendly_empty_state.dart';
import '../../widgets/common/page_header.dart';

class TripsScreen extends ConsumerWidget {
  const TripsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carId = ref.watch(selectedCarIdProvider);
    final l10n = AppLocalizations.of(context)!;

    if (carId == null) return Center(child: Text(l10n.noCarSelected));

    final tripsAsync = ref.watch(tripsProvider(carId));
    final car = ref.watch(selectedCarProvider);
    final distanceUnit = car?.milageUnit ?? 'km';
    final currency = car?.currency ?? 'EUR';

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(icon: Icons.route_outlined, title: l10n.tripsTitle),
          Expanded(
            child: AsyncValueWidget(
              value: tripsAsync,
              data: (collection) {
                final trips = collection.members;
                if (trips.isEmpty) {
                  return FriendlyEmptyState(
                    icon: Icons.route_outlined,
                    title: l10n.noTrips,
                    actionLabel: l10n.newTrip,
                    onAction: () => context.push('/trips/new'),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 96),
                  itemCount: trips.length,
                  itemBuilder: (context, index) {
                    final t = trips[index];
                    return _TripCard(
                      trip: t,
                      distanceUnit: distanceUnit,
                      currency: currency,
                      onEdit: () => context.push('/trips/${t.id}/edit'),
                      onDelete: () async {
                        final confirmed = await showConfirmDialog(
                          context,
                          title: l10n.deleteTrip,
                          message: l10n.deleteTripConfirm,
                          confirmLabel: l10n.delete,
                        );
                        if (confirmed) {
                          await ref.read(tripApiProvider).deleteTrip(t.id);
                          ref.invalidate(tripsProvider(carId));
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/trips/new'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _TripCard extends StatelessWidget {
  const _TripCard({
    required this.trip,
    required this.distanceUnit,
    required this.currency,
    required this.onEdit,
    required this.onDelete,
  });

  final Trip trip;
  final String distanceUnit;
  final String currency;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final dateFmt = DateFormat.yMMMd(locale).add_Hm();
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onLongPress: onDelete,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 4, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date range
                    Text(
                      dateFmt.format(trip.startTime),
                      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    if (trip.endTime != null)
                      Text(
                        '→ ${dateFmt.format(trip.endTime!)}',
                        style: theme.textTheme.bodyMedium,
                      ),
                    const SizedBox(height: 6),
                    // Mileage row
                    Wrap(
                      spacing: 16,
                      children: [
                        if (trip.startMileage != null)
                          _InfoChip(
                            label: l10n.tripStart,
                            value: '${trip.startMileage} $distanceUnit',
                          ),
                        if (trip.endMileage != null)
                          _InfoChip(
                            label: l10n.tripEnd,
                            value: '${trip.endMileage} $distanceUnit',
                          ),
                        if (trip.distanceKm > 0)
                          _InfoChip(
                            label: l10n.tripDistance,
                            value: '${trip.distanceKm.toStringAsFixed(0)} $distanceUnit',
                            bold: true,
                          ),
                        if (trip.costs != null)
                          _InfoChip(
                            label: l10n.tripCosts,
                            value: '${trip.costs!.toStringAsFixed(2)} $currency',
                          ),
                      ],
                    ),
                    // Users
                    if (trip.users.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      _InfoChip(
                        label: l10n.tripDriver,
                        value: trip.users.length == 1
                            ? trip.users.first.name
                            : l10n.tripMultipleDrivers,
                      ),
                    ],
                    // Comment
                    if (trip.purpose != null && trip.purpose!.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        trip.purpose!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: onEdit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label, required this.value, this.bold = false});

  final String label;
  final String value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),),
        Text(
          value,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
