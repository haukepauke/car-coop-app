import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/extensions/string_extensions.dart';
import '../../../data/api/expense_api.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/expense_provider.dart';
import '../../../providers/car_provider.dart';

const _types = ['fuel', 'charging', 'service', 'other'];

class ExpenseFormScreen extends ConsumerStatefulWidget {
  const ExpenseFormScreen({super.key, this.expenseId});

  final int? expenseId;

  @override
  ConsumerState<ExpenseFormScreen> createState() => _ExpenseFormScreenState();
}

class _ExpenseFormScreenState extends ConsumerState<ExpenseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _commentController = TextEditingController();
  final _amountController = TextEditingController();
  String _type = _types.first;
  DateTime _date = DateTime.now();
  int? _userId;
  bool _loading = false;

  bool get _isEditing => widget.expenseId != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) _loadExpense();
  }

  Future<void> _loadExpense() async {
    final expense = await ref.read(expenseApiProvider).getExpense(widget.expenseId!);
    _nameController.text = expense.name ?? '';
    _commentController.text = expense.description ?? '';
    _amountController.text = expense.amount.toString();
    setState(() {
      _type = expense.category;
      _date = expense.date;
      _userId = expense.user?.id;
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
        'type': _type,
        'name': _nameController.text,
        'amount': double.parse(_amountController.text),
        if (_commentController.text.isNotEmpty) 'comment': _commentController.text,
        if (_userId != null) 'user': toIri('users', _userId!),
      };
      if (_isEditing) {
        await ref.read(expenseApiProvider).updateExpense(widget.expenseId!, data);
      } else {
        await ref.read(expenseApiProvider).createExpense(data);
      }
      ref.invalidate(expensesProvider(carId));
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
    _nameController.dispose();
    _commentController.dispose();
    _amountController.dispose();
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
      appBar: AppBar(title: Text(_isEditing ? l10n.editExpense : l10n.newExpense)),
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
              DropdownButtonFormField<String>(
                key: ValueKey('type-$_type'),
                initialValue: _type,
                decoration: InputDecoration(
                  labelText: l10n.tripType,
                  border: const OutlineInputBorder(),
                ),
                items: _types
                    .map((t) => DropdownMenuItem(
                          value: t,
                          child: Text(t[0].toUpperCase() + t.substring(1)),
                        ),)
                    .toList(),
                onChanged: (v) => setState(() => _type = v!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: l10n.expenseName,
                  border: const OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.isEmpty) ? l10n.expenseNameRequired : null,
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
              DropdownButtonFormField<int>(
                key: ValueKey('user-$_userId'),
                initialValue: _userId,
                decoration: InputDecoration(
                  labelText: l10n.user,
                  border: const OutlineInputBorder(),
                ),
                items: memberItems,
                onChanged: (v) => setState(() => _userId = v),
                validator: (v) => v == null ? l10n.selectUser : null,
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
