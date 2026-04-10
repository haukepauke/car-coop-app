import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/constants/app_constants.dart';
import '../data/api/car_api.dart';
import '../data/models/api_collection.dart';
import '../data/models/car.dart';
import 'settings_provider.dart';

part 'car_provider.g.dart';

@riverpod
Future<ApiCollection<Car>> cars(CarsRef ref) async {
  return ref.watch(carApiProvider).getCars();
}

/// The currently selected car ID (persisted in SharedPreferences).
final selectedCarIdProvider = StateProvider<int?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getInt(AppConstants.selectedCarIdKey);
});

Future<void> selectCar(WidgetRef ref, int carId) async {
  final prefs = ref.read(sharedPreferencesProvider);
  await prefs.setInt(AppConstants.selectedCarIdKey, carId);
  ref.read(selectedCarIdProvider.notifier).state = carId;
}

/// True when any car is selected — use this in the router to avoid
/// rebuilding the entire GoRouter every time the user switches cars.
final hasSelectedCarProvider = Provider<bool>((ref) {
  return ref.watch(selectedCarIdProvider) != null;
});

/// Convenience provider that returns the selected Car object (or null).
final selectedCarProvider = Provider<Car?>((ref) {
  final carId = ref.watch(selectedCarIdProvider);
  final carsAsync = ref.watch(carsProvider);
  return carsAsync.whenOrNull(
    data: (collection) => collection.members
        .where((c) => c.id == carId)
        .cast<Car?>()
        .firstOrNull,
  );
});
