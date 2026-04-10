import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/extensions/string_extensions.dart';
import '../../../data/api/payment_api.dart';
import '../../../data/models/payment.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/car_provider.dart';
import '../../../providers/payment_provider.dart';

class PaymentFormScreen extends ConsumerStatefulWidget {
  const PaymentFormScreen({super.key, this.paymentId});

  final int? paymentId;

  @override
  ConsumerState<PaymentFormScreen> createState() => _PaymentFormScreenState();
}

class _PaymentFormScreenState extends ConsumerState<PaymentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _commentController = TextEditingController();
  DateTime _date = DateTime.now();
  String _type = Payment.types.first;
  int? _paidByUserId;
  int? _paidToUserId;
  bool _loading = false;

  bool get _isEditing => widget.paymentId != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) _loadPayment();
  }

  Future<void> _loadPayment() async {
    final payment = await ref.read(paymentApiProvider).getPayment(widget.paymentId!);
    _amountController.text = payment.amount.toString();
    _commentController.text = payment.note ?? '';
    setState(() {
      _date = payment.date;
      if (payment.type != null) _type = payment.type!;
      _paidByUserId = payment.paidBy?.id;
      _paidToUserId = payment.paidTo?.id;
    });
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (date != null) setState(() => _date = date);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      final carId = ref.read(selectedCarIdProvider)!;
      final data = {
        'car': toIri('cars', carId),
        'date': _date.toIso8601String(),
        'amount': double.parse(_amountController.text),
        'type': _type,
        if (_paidByUserId != null) 'fromUser': toIri('users', _paidByUserId!),
        if (_paidToUserId != null) 'toUser': toIri('users', _paidToUserId!),
        if (_commentController.text.isNotEmpty) 'comment': _commentController.text,
      };
      if (_isEditing) {
        await ref.read(paymentApiProvider).updatePayment(widget.paymentId!, data);
      } else {
        await ref.read(paymentApiProvider).createPayment(data);
      }
      ref.invalidate(paymentsProvider(carId));
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
        );
      }
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final members = ref.watch(selectedCarProvider)?.members ?? [];
    final memberItems = members
        .map((m) => DropdownMenuItem(value: m.id, child: Text(m.name)))
        .toList();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(_isEditing ? l10n.editPayment : l10n.newPayment)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: Text(l10n.date),
                subtitle: Text(DateFormat('MMM d, yyyy').format(_date)),
                onTap: _pickDate,
                tileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: l10n.expenseAmount,
                  border: const OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return l10n.amountRequired;
                  if (double.tryParse(v) == null) return l10n.enterValidNumber;
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                key: ValueKey('type-$_type'),
                initialValue: _type,
                decoration: InputDecoration(
                  labelText: l10n.paymentType,
                  border: const OutlineInputBorder(),
                ),
                items: Payment.types
                    .map((t) => DropdownMenuItem(
                          value: t,
                          child: Text(t[0].toUpperCase() + t.substring(1)),
                        ),)
                    .toList(),
                onChanged: (v) => setState(() => _type = v!),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                key: ValueKey('paidBy-$_paidByUserId'),
                initialValue: _paidByUserId,
                decoration: InputDecoration(
                  labelText: l10n.paymentFrom,
                  border: const OutlineInputBorder(),
                ),
                items: memberItems,
                onChanged: (v) => setState(() => _paidByUserId = v),
                validator: (v) => v == null ? l10n.paymentSelectPaidBy : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                key: ValueKey('paidTo-$_paidToUserId'),
                initialValue: _paidToUserId,
                decoration: InputDecoration(
                  labelText: l10n.paymentTo,
                  border: const OutlineInputBorder(),
                ),
                items: memberItems,
                onChanged: (v) => setState(() => _paidToUserId = v),
                validator: (v) => v == null ? l10n.paymentSelectRecipient : null,
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
