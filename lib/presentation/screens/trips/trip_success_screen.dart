import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/trip.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/car_provider.dart';

class TripSuccessScreen extends ConsumerWidget {
  const TripSuccessScreen({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final car = ref.watch(selectedCarProvider);
    final distanceUnit = car?.milageUnit ?? 'km';
    final currency = car?.currency ?? 'EUR';
    final distance = trip.distanceKm;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.tripRecorded),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle_outline, size: 80, color: Colors.green),
              const SizedBox(height: 24),
              Text(
                l10n.tripSaved,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              _StatCard(
                icon: Icons.route,
                label: l10n.tripDistance,
                value: '${distance.toStringAsFixed(0)} $distanceUnit',
              ),
              if (trip.costs != null) ...[
                const SizedBox(height: 16),
                _StatCard(
                  icon: Icons.euro_outlined,
                  label: l10n.tripCosts,
                  value: '${trip.costs!.toStringAsFixed(2)} $currency',
                ),
              ],
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => context.go('/trips'),
                  child: Text(l10n.tripBackToList),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          children: [
            Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: Theme.of(context).textTheme.labelMedium),
                Text(
                  value,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
