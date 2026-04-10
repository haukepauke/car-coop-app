import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/car.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/car_provider.dart';
import '../../../providers/settings_provider.dart';
import '../../widgets/common/user_avatar.dart';

class CarSelectionScreen extends ConsumerWidget {
  const CarSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carsAsync = ref.watch(carsProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.selectCar)),
      body: carsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 16),
              Text(error.toString()),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => ref.invalidate(carsProvider),
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
        data: (collection) {
          final cars = collection.members;

          // 0 cars → send user to the website to join a group.
          if (cars.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.directions_car_outlined, size: 64),
                    const SizedBox(height: 16),
                    Text(
                      l10n.noCarMember,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    FilledButton.icon(
                      icon: const Icon(Icons.open_in_browser),
                      label: Text(l10n.goToWebsite),
                      onPressed: () => launchUrl(
                        Uri.parse('https://app.car-coop.net/'),
                        mode: LaunchMode.externalApplication,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // 1 car → auto-select and skip the screen.
          if (cars.length == 1) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              await selectCar(ref, cars.first.id);
              if (context.mounted) context.go('/bookings');
            });
            return const Center(child: CircularProgressIndicator());
          }

          // 2+ cars → show the list.
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: cars.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) => _CarTile(car: cars[index]),
          );
        },
      ),
    );
  }
}

class _CarTile extends ConsumerWidget {
  const _CarTile({required this.car});

  final Car car;

  Color _carColor(BuildContext context) {
    if (car.color == null) return Theme.of(context).colorScheme.primary;
    final hex = car.color!.replaceAll('#', '');
    if (hex.length == 6) {
      return Color(int.parse('FF$hex', radix: 16));
    }
    return Theme.of(context).colorScheme.primary;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiUrl = ref.watch(apiUrlProvider) ?? '';
    final picturePath = car.profilePicturePath;

    final leading = picturePath != null && picturePath.isNotEmpty
        ? CircleAvatar(
            radius: 28,
            backgroundColor: _carColor(context).withAlpha(30),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: '$apiUrl/uploads/cars/$picturePath',
                width: 56,
                height: 56,
                fit: BoxFit.cover,
                placeholder: (_, __) => const CircularProgressIndicator(strokeWidth: 2),
                errorWidget: (_, __, ___) =>
                    Icon(Icons.directions_car, color: _carColor(context), size: 28),
              ),
            ),
          )
        : CircleAvatar(
            radius: 28,
            backgroundColor: _carColor(context).withAlpha(30),
            child: Icon(Icons.directions_car, color: _carColor(context), size: 28),
          );

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: leading,
      title: Text(car.name, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(car.licensePlate),
          if (car.members.isNotEmpty) ...[
            const SizedBox(height: 6),
            Wrap(
              spacing: 4,
              children: car.members.map((m) => UserAvatar(user: m, radius: 12)).toList(),
            ),
          ],
        ],
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () async {
        await selectCar(ref, car.id);
        if (context.mounted) context.go('/bookings');
      },
    );
  }
}
