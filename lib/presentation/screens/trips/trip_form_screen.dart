import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../core/extensions/string_extensions.dart';
import '../../../core/extensions/exception_extensions.dart';
import '../../../data/api/trip_api.dart';
import '../../../data/models/trip.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/car_provider.dart';
import '../../../providers/trip_provider.dart';

class TripFormScreen extends ConsumerStatefulWidget {
  const TripFormScreen({super.key, this.tripId});

  final int? tripId;

  @override
  ConsumerState<TripFormScreen> createState() => _TripFormScreenState();
}

class _TripFormScreenState extends ConsumerState<TripFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _startMileageController = TextEditingController();
  final _endMileageController = TextEditingController();
  final _commentController = TextEditingController();
  DateTime? _startTime;
  DateTime? _endTime;
  String _type = Trip.types.first;
  Set<int> _selectedUserIds = {};
  bool _loading = false;
  bool _scanningMileage = false;
  bool _endMileageReadOnly = false;

  bool get _isEditing => widget.tripId != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _loadTrip();
    } else {
      _initNewTrip();
    }
  }

  void _applyCurrentUser() {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser != null && mounted) {
      setState(() => _selectedUserIds = {currentUser.id});
    }
  }

  Future<void> _initNewTrip() async {
    final carId = ref.read(selectedCarIdProvider);
    if (carId == null) return;

    // Default end time to now.
    setState(() => _endTime = DateTime.now());

    // Pre-select the current user — try immediately, then listen in case
    // the auth state hasn't resolved yet.
    _applyCurrentUser();
    if (_selectedUserIds.isEmpty) {
      ref.listenManual(currentUserProvider, (_, user) {
        if (user != null && _selectedUserIds.isEmpty) _applyCurrentUser();
      });
    }

    // Set start mileage and start time from the most recent trip.
    try {
      final collection = await ref.read(tripsProvider(carId).future);
      final trips = collection.members;
      if (mounted) {
        final last = trips.isNotEmpty ? trips.first : null;
        final startMileage = last?.endMileage ?? ref.read(selectedCarProvider)?.mileage;
        setState(() {
          if (startMileage != null) {
            _startMileageController.text = startMileage.toString();
          }
          if (last?.endTime != null) _startTime = last!.endTime;
        });
      }
    } catch (_) {
      final carMileage = ref.read(selectedCarProvider)?.mileage;
      if (carMileage != null && mounted) {
        setState(() => _startMileageController.text = carMileage.toString());
      }
    }
  }

  Future<void> _loadTrip() async {
    final carId = ref.read(selectedCarIdProvider);
    final trip = await ref.read(tripApiProvider).getTrip(widget.tripId!);

    bool endReadOnly = false;
    if (carId != null) {
      try {
        final collection = await ref.read(tripsProvider(carId).future);
        final latestId = collection.members.isNotEmpty ? collection.members.first.id : null;
        endReadOnly = latestId != widget.tripId;
      } catch (_) {
        endReadOnly = false;
      }
    }

    _startMileageController.text = trip.startMileage?.toString() ?? '';
    _endMileageController.text = trip.endMileage?.toString() ?? '';
    _commentController.text = trip.purpose ?? '';
    setState(() {
      _startTime = trip.startTime;
      _endTime = trip.endTime;
      if (trip.type != null) _type = trip.type!;
      _selectedUserIds = trip.users.map((u) => u.id).toSet();
      _endMileageReadOnly = endReadOnly;
    });
  }

  Future<void> _pickDateTime(bool isStart) async {
    final initial = (isStart ? _startTime : _endTime) ?? DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );
    if (time == null) return;
    final dt = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() => isStart ? _startTime = dt : _endTime = dt);
  }

  Future<void> _scanMileage() async {
    final l10n = AppLocalizations.of(context)!;
    final picker = ImagePicker();
    final photo = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 90,
    );
    if (photo == null) return;

    setState(() => _scanningMileage = true);
    try {
      final inputImage = InputImage.fromFilePath(photo.path);
      final recognizer = TextRecognizer(script: TextRecognitionScript.latin);
      final result = await recognizer.processImage(inputImage);
      await recognizer.close();

      final numbers = <int>[];
      for (final block in result.blocks) {
        final cleaned = block.text.replaceAll(RegExp(r'[\s.,]'), '');
        final matches = RegExp(r'\d{4,7}').allMatches(cleaned);
        for (final m in matches) {
          final value = int.tryParse(m.group(0)!);
          if (value != null) numbers.add(value);
        }
      }

      if (numbers.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.scanNoMileage)),
          );
        }
        return;
      }

      numbers.sort();
      final mileage = numbers.last;
      setState(() => _endMileageController.text = mileage.toString());
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toLocalizedMessage(context)), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _scanningMileage = false);
    }
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) return;
    if (_startTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.pleaseSelectStartTime)),
      );
      return;
    }
    setState(() => _loading = true);
    try {
      final carId = ref.read(selectedCarIdProvider)!;
      final data = {
        'car': toIri('cars', carId),
        'startDate': _startTime!.toIso8601String(),
        if (_endTime != null) 'endDate': _endTime!.toIso8601String(),
        'type': _type,
        if (_startMileageController.text.isNotEmpty)
          'startMileage': int.parse(_startMileageController.text),
        if (_endMileageController.text.isNotEmpty)
          'endMileage': int.parse(_endMileageController.text),
        if (_commentController.text.isNotEmpty) 'comment': _commentController.text,
        'users': _selectedUserIds.map((id) => toIri('users', id)).toList(),
      };
      if (_isEditing) {
        await ref.read(tripApiProvider).updateTrip(widget.tripId!, data);
        ref.invalidate(tripsProvider(carId));
        if (mounted) context.pop();
      } else {
        final created = await ref.read(tripApiProvider).createTrip(data);
        ref.invalidate(tripsProvider(carId));
        if (mounted) context.pushReplacement('/trips/success', extra: created);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toLocalizedMessage(context)), backgroundColor: Colors.red),
        );
      }
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _startMileageController.dispose();
    _endMileageController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('MMM d, yyyy HH:mm');
    final members = ref.watch(selectedCarProvider)?.members ?? [];
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(_isEditing ? l10n.editTrip : l10n.newTrip)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _startMileageController,
                keyboardType: TextInputType.number,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: l10n.tripStartMileage,
                  border: const OutlineInputBorder(),
                  filled: true,
                ),
                validator: (v) {
                  if (v != null && v.isNotEmpty && int.tryParse(v) == null) {
                    return l10n.enterWholeNumber;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _endMileageController,
                      keyboardType: TextInputType.number,
                      readOnly: _endMileageReadOnly,
                      decoration: InputDecoration(
                        labelText: l10n.tripEndMileage,
                        border: const OutlineInputBorder(),
                        filled: _endMileageReadOnly,
                        helperText: _endMileageReadOnly ? l10n.tripEndMileageLocked : null,
                      ),
                      validator: (v) {
                        if (v != null && v.isNotEmpty && int.tryParse(v) == null) {
                          return l10n.enterWholeNumber;
                        }
                        return null;
                      },
                    ),
                  ),
                  if (!_endMileageReadOnly) ...[
                    const SizedBox(width: 8),
                    SizedBox(
                      height: 56,
                      child: Tooltip(
                        message: l10n.scanMileage,
                        child: FilledButton.tonal(
                          onPressed: _scanningMileage ? null : _scanMileage,
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                          ),
                          child: _scanningMileage
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Icon(Icons.camera_alt_outlined),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.schedule),
                title: Text(l10n.tripStartTime),
                subtitle: Text(_startTime != null ? fmt.format(_startTime!) : l10n.notSet),
                onTap: _endMileageReadOnly ? null : () => _pickDateTime(true),
                enabled: !_endMileageReadOnly,
                tileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: const Icon(Icons.schedule_outlined),
                title: Text(l10n.tripEndTime),
                subtitle: Text(_endTime != null ? fmt.format(_endTime!) : l10n.notSet),
                onTap: _endMileageReadOnly ? null : () => _pickDateTime(false),
                enabled: !_endMileageReadOnly,
                tileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                key: ValueKey('type-$_type'),
                initialValue: _type,
                decoration: InputDecoration(
                  labelText: l10n.tripType,
                  border: const OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(value: 'vacation', child: Text(l10n.tripTypeVacation)),
                  DropdownMenuItem(value: 'transport', child: Text(l10n.tripTypeTransport)),
                  DropdownMenuItem(value: 'service', child: Text(l10n.tripTypeService)),
                ],
                onChanged: (v) => setState(() => _type = v!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _commentController,
                decoration: InputDecoration(
                  labelText: l10n.tripComment,
                  border: const OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              if (members.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(l10n.tripUsers, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 4),
                ...members.map((m) => CheckboxListTile(
                      dense: true,
                      title: Text(m.name),
                      value: _selectedUserIds.contains(m.id),
                      onChanged: (checked) => setState(() {
                        if (checked == true) {
                          _selectedUserIds = {..._selectedUserIds, m.id};
                        } else {
                          _selectedUserIds =
                              _selectedUserIds.where((id) => id != m.id).toSet();
                        }
                      }),
                    ),),
              ],
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
