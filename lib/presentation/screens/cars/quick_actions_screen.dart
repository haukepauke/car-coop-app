import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../../providers/car_provider.dart';
import '../../../providers/settings_provider.dart';
import '../trips/trip_form_screen.dart';
import '../../widgets/common/app_message_dialog.dart';

class QuickActionsScreen extends ConsumerStatefulWidget {
  const QuickActionsScreen({super.key});

  @override
  ConsumerState<QuickActionsScreen> createState() => _QuickActionsScreenState();
}

class _QuickActionsScreenState extends ConsumerState<QuickActionsScreen> {
  bool _isCheckingMileage = false;

  void _navigateAfterDialog(VoidCallback navigation) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      navigation();
    });
  }

  Color _carAccentColor(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return Theme.of(context).colorScheme.primary;
    }
    final hex = value.replaceAll('#', '');
    if (hex.length == 6) {
      return Color(int.parse('FF$hex', radix: 16));
    }
    return Theme.of(context).colorScheme.primary;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final car = ref.watch(selectedCarProvider);
    final accent = _carAccentColor(context, car?.color);
    final apiUrl = ref.watch(apiUrlProvider) ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.quickActionsTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_rounded),
            onPressed: () => context.go('/bookings'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _isCheckingMileage
              ? _buildMileageCheck(car?.mileage ?? 0, l10n, accent)
              : _buildActionsList(
                  l10n,
                  car?.name,
                  car?.licensePlate,
                  car?.mileage,
                  car?.milageUnit,
                  accent,
                  apiUrl,
                  car?.profilePicturePath,
                ),
        ),
      ),
    );
  }

  Widget _buildActionsList(
    AppLocalizations l10n,
    String? carName,
    String? licensePlate,
    int? mileage,
    String? mileageUnit,
    Color accent,
    String apiUrl,
    String? picturePath,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return ListView(
      key: const ValueKey('actions_list'),
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              colors: [
                accent.withAlpha(230),
                scheme.secondaryContainer,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withAlpha(60),
                ),
                child: ClipOval(
                  child: picturePath != null && picturePath.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: '$apiUrl/uploads/cars/$picturePath',
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => const Center(
                            child: SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          errorWidget: (_, __, ___) => const Icon(
                            Icons.directions_car_filled_outlined,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(
                          Icons.directions_car_filled_outlined,
                          color: Colors.white,
                        ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                carName ?? l10n.quickActionsTitle,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              if (licensePlate != null) ...[
                const SizedBox(height: 4),
                Text(
                  licensePlate,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white.withAlpha(215),
                    letterSpacing: 0.5,
                  ),
                ),
              ],
              const SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  if (mileage != null)
                    _HeroChip(
                      icon: Icons.speed_outlined,
                      label: '$mileage ${mileageUnit ?? 'km'}',
                    ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.24,
          children: [
            _QuickActionCard(
              label: l10n.findVehicle,
              icon: Icons.map_outlined,
              accent: accent,
              onPressed: () => context.go('/parking'),
            ),
            _QuickActionCard(
              label: l10n.startTrip,
              icon: Icons.play_circle_outline,
              accent: accent,
              onPressed: () => setState(() => _isCheckingMileage = true),
            ),
            _QuickActionCard(
              label: l10n.addExpense,
              icon: Icons.receipt_long_outlined,
              accent: accent,
              onPressed: () => context.go('/expenses/new'),
            ),
            _QuickActionCard(
              label: l10n.parkCar,
              icon: Icons.local_parking_outlined,
              accent: accent,
              onPressed: () => context.go('/parking'),
            ),
            _QuickActionCard(
              label: l10n.finishTrip,
              icon: Icons.check_circle_outline,
              accent: accent,
              onPressed: () => context.go('/trips/new'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMileageCheck(int mileage, AppLocalizations l10n, Color accent) {
    return Column(
      key: const ValueKey('mileage_check'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 92,
          height: 92,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [accent, accent.withAlpha(120)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Icon(Icons.speed, size: 44, color: Colors.white),
        ),
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
                  _navigateAfterDialog(
                    () => context.push(
                      '/trips/new',
                      extra: TripFormPreset(
                        type: 'placeholder_free',
                        comment: l10n.tripPlaceholderComment,
                      ),
                    ),
                  );
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
                  _navigateAfterDialog(() => context.go('/messages'));
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

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.accent,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accent.withAlpha(28),
                ),
                child: Icon(icon, color: accent, size: 22),
              ),
              const Spacer(),
              Text(
                label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Icon(Icons.arrow_forward_rounded, color: scheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  const _HeroChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(52),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
