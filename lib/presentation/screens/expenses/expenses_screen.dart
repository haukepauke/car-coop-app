import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../data/api/expense_api.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/car_provider.dart';
import '../../../providers/expense_provider.dart';
import '../../widgets/common/async_value_widget.dart';
import '../../widgets/common/confirm_dialog.dart';
import '../../widgets/common/friendly_empty_state.dart';
import '../../widgets/common/page_header.dart';

class ExpensesScreen extends ConsumerWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = Localizations.localeOf(context).toString();
    final carId = ref.watch(selectedCarIdProvider);
    final l10n = AppLocalizations.of(context)!;

    if (carId == null) return Center(child: Text(l10n.noCarSelected));

    final expensesAsync = ref.watch(expensesProvider(carId));
    final currencyFmt = NumberFormat.currency(symbol: '€');
    final dateFmt = DateFormat.yMMMd(locale);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(icon: Icons.receipt_long_outlined, title: l10n.expensesTitle),
          Expanded(
            child: AsyncValueWidget(
              value: expensesAsync,
              data: (collection) {
                final expenses = collection.members;
                if (expenses.isEmpty) {
                  return FriendlyEmptyState(
                    icon: Icons.receipt_long_outlined,
                    title: l10n.noExpenses,
                    actionLabel: l10n.newExpense,
                    onAction: () => context.push('/expenses/new'),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 96),
                  itemCount: expenses.length,
                  itemBuilder: (context, index) {
                    final e = expenses[index];
                    return ListTile(
                      title: Text('${e.name ?? e.category} · ${currencyFmt.format(e.amount)}'),
                      subtitle: Text('${dateFmt.format(e.date)} by ${e.user?.name ?? 'Unknown'}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        onPressed: () => context.push('/expenses/${e.id}/edit'),
                      ),
                      onLongPress: () async {
                        final confirmed = await showConfirmDialog(
                          context,
                          title: l10n.deleteExpense,
                          message: l10n.deleteExpenseConfirm,
                          confirmLabel: l10n.delete,
                        );
                        if (confirmed) {
                          await ref.read(expenseApiProvider).deleteExpense(e.id);
                          ref.invalidate(expensesProvider(carId));
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
        onPressed: () => context.push('/expenses/new'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
