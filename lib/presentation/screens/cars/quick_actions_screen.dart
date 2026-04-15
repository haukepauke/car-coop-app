import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../../providers/car_provider.dart';
import '../../widgets/common/app_message_dialog.dart';

class QuickActionsScreen extends ConsumerStatefulWidget {
  const QuickActionsScreen({super.key});

  @override
  ConsumerState<QuickActionsScreen> createState() => _QuickActionsScreenState();
}

class _QuickActionsScreenState extends ConsumerState<QuickActionsScreen> {
  bool _isCheckingMileage = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final car = ref.watch(selectedCarProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.quickActionsTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month_outlined),
            onPressed: () => context.go('/bookings'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _isCheckingMileage
              ? _buildMileageCheck(car?.mileage ?? 0, l10n)
              : _buildActionsList(l10n),
        ),
      ),
    );
  }

  Widget _buildActionsList(AppLocalizations l10n) {
    return Column(
      key: const ValueKey('actions_list'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _QuickActionButton(
          label: l10n.findVehicle,
          icon: Icons.map_outlined,
          onPressed: () => context.push('/parking'),
        ),
        _QuickActionButton(
          label: l10n.startTrip,
          icon: Icons.play_circle_outline,
          onPressed: () => setState(() => _isCheckingMileage = true),
        ),
        _QuickActionButton(
          label: l10n.addExpense,
          icon: Icons.receipt_long_outlined,
          onPressed: () => context.push('/expenses/new'),
        ),
        _QuickActionButton(
          label: l10n.parkCar,
          icon: Icons.local_parking_outlined,
          onPressed: () => context.push('/parking'),
        ),
        _QuickActionButton(
          label: l10n.finishTrip,
          icon: Icons.check_circle_outline,
          onPressed: () => context.push('/trips/new'),
        ),
      ],
    );
  }

  Widget _buildMileageCheck(int mileage, AppLocalizations l10n) {
    return Column(
      key: const ValueKey('mileage_check'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.speed, size: 64, color: Colors.blue),
        const SizedBox(height: 24),
        Text(
          l10n.mileageCheck(mileage),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () async {
                  await showAppMessageDialog(
                    context,
                    message: l10n.tempTripNotice,
                    type: AppMessageType.info,
                  );
                  if (!mounted) return;
                  context.push('/trips/new');
                },
                child: Text(l10n.no),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: FilledButton(
                onPressed: () async {
                  await showAppMessageDialog(
                    context,
                    message: l10n.haveNiceTrip,
                    type: AppMessageType.success,
                  );
                  if (!mounted) return;
                  context.go('/messages');
                },
                child: Text(l10n.yes),
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () => setState(() => _isCheckingMileage = false),
          child: Text(l10n.cancel),
        ),
      ],
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _QuickActionButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: FilledButton.tonalIcon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label),
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          alignment: Alignment.centerLeft,
        ),
      ),
    );
  }
}
