import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../data/api/payment_api.dart';
import '../../../data/models/user_ref.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/car_provider.dart';
import '../../../providers/payment_provider.dart';
import '../../widgets/common/async_value_widget.dart';
import '../../widgets/common/confirm_dialog.dart';
import '../../widgets/common/page_header.dart';

class PaymentsScreen extends ConsumerWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carId = ref.watch(selectedCarIdProvider);
    final l10n = AppLocalizations.of(context)!;

    if (carId == null) return Center(child: Text(l10n.noCarSelected));

    final paymentsAsync = ref.watch(paymentsProvider(carId));
    final members = ref.watch(selectedCarProvider)?.members ?? [];
    final currencyFmt = NumberFormat.currency(symbol: '€');
    final dateFmt = DateFormat('MMM d, yyyy');

    String userName(UserRef? userRef) {
      if (userRef == null) return '?';
      final match = members.where((m) => m.id == userRef.id).firstOrNull;
      final name = match?.name ?? userRef.name;
      return name.isNotEmpty ? name : '?';
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(icon: Icons.payments_outlined, title: l10n.paymentsTitle),
          Expanded(
            child: AsyncValueWidget(
              value: paymentsAsync,
              data: (collection) {
                final payments = collection.members;
                if (payments.isEmpty) return Center(child: Text(l10n.noPayments));
                return ListView.builder(
                  itemCount: payments.length,
                  itemBuilder: (context, index) {
                    final p = payments[index];
                    return ListTile(
                      title: Text(currencyFmt.format(p.amount)),
                      subtitle: Text(
                        '${userName(p.paidBy)} → ${userName(p.paidTo)}\n${dateFmt.format(p.date)}',
                      ),
                      isThreeLine: true,
                      trailing: IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        onPressed: () => context.push('/payments/${p.id}/edit'),
                      ),
                      onLongPress: () async {
                        final confirmed = await showConfirmDialog(
                          context,
                          title: l10n.deletePayment,
                          message: l10n.deletePaymentConfirm,
                          confirmLabel: l10n.delete,
                        );
                        if (confirmed) {
                          await ref.read(paymentApiProvider).deletePayment(p.id);
                          ref.invalidate(paymentsProvider(carId));
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
        onPressed: () => context.push('/payments/new'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
