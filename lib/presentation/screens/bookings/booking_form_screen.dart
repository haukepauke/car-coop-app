import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/extensions/string_extensions.dart';
import '../../../core/extensions/exception_extensions.dart';
import '../../../data/api/booking_api.dart';
import '../../../data/models/booking.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/booking_provider.dart';
import '../../../providers/car_provider.dart';
import '../../widgets/common/app_message_dialog.dart';

class BookingFormScreen extends ConsumerStatefulWidget {
  const BookingFormScreen({super.key, this.bookingId});

  final int? bookingId;

  @override
  ConsumerState<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends ConsumerState<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  DateTime? _startTime;
  DateTime? _endTime;
  String _status = Booking.statuses.first;
  int? _userId;
  bool _loading = false;

  bool get _isEditing => widget.bookingId != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) _loadBooking();
  }

  Future<void> _loadBooking() async {
    final booking = await ref.read(bookingApiProvider).getBooking(widget.bookingId!);
    _titleController.text = booking.purpose ?? '';
    setState(() {
      _startTime = booking.startTime;
      _endTime = booking.endTime;
      if (booking.status != null) _status = booking.status!;
      _userId = booking.user?.id;
    });
  }

  Future<void> _pickDateTime(bool isStart) async {
    final initial = (isStart ? _startTime : _endTime) ?? DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );
    if (time == null) return;
    final dt = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() {
      if (isStart) {
        _startTime = dt;
      } else {
        _endTime = dt;
      }
    });
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) return;
    if (_startTime == null || _endTime == null) {
      await showAppMessageDialog(
        context,
        message: l10n.bookingSelectStartEnd,
        type: AppMessageType.warning,
      );
      return;
    }
    setState(() => _loading = true);
    try {
      final carId = ref.read(selectedCarIdProvider)!;
      final data = {
        'car': toIri('cars', carId),
        'startDate': _startTime!.toIso8601String(),
        'endDate': _endTime!.toIso8601String(),
        'status': _status,
        if (_titleController.text.isNotEmpty) 'title': _titleController.text,
        if (_userId != null) 'user': toIri('users', _userId!),
      };
      if (_isEditing) {
        await ref.read(bookingApiProvider).updateBooking(widget.bookingId!, data);
      } else {
        await ref.read(bookingApiProvider).createBooking(data);
      }
      ref.invalidate(bookingsProvider(carId));
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        await showAppMessageDialog(
          context,
          message: e.toLocalizedMessage(context),
          type: AppMessageType.error,
        );
      }
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final fmt = DateFormat.yMMMd(locale).add_Hm();
    final members = ref.watch(selectedCarProvider)?.members ?? [];
    final memberItems = members
        .map((m) => DropdownMenuItem(value: m.id, child: Text(m.name)))
        .toList();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(_isEditing ? l10n.editBooking : l10n.newBooking)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                leading: const Icon(Icons.schedule),
                title: Text(l10n.bookingStartTime),
                subtitle: Text(_startTime != null ? fmt.format(_startTime!) : l10n.notSet),
                onTap: () => _pickDateTime(true),
                tileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: const Icon(Icons.schedule_outlined),
                title: Text(l10n.bookingEndTime),
                subtitle: Text(_endTime != null ? fmt.format(_endTime!) : l10n.notSet),
                onTap: () => _pickDateTime(false),
                tileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: l10n.bookingTitleOptional,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                key: ValueKey('status-$_status'),
                initialValue: _status,
                decoration: InputDecoration(
                  labelText: l10n.bookingStatus,
                  border: const OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(value: 'fixed', child: Text(l10n.bookingStatusFixed)),
                  DropdownMenuItem(value: 'maybe', child: Text(l10n.bookingStatusMaybe)),
                ],
                onChanged: (v) => setState(() => _status = v!),
                validator: (v) => v == null ? l10n.bookingSelectStatus : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                key: ValueKey('user-$_userId'),
                initialValue: _userId,
                decoration: InputDecoration(
                  labelText: l10n.user,
                  border: const OutlineInputBorder(),
                ),
                items: memberItems,
                onChanged: (v) => setState(() => _userId = v),
                validator: (v) => v == null ? l10n.bookingSelectUser : null,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _loading ? null : _submit,
                child: _loading
                    ? const CircularProgressIndicator(strokeWidth: 2)
                    : Text(_isEditing ? l10n.update : l10n.create),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
