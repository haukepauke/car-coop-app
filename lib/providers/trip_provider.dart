import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/extensions/string_extensions.dart';
import '../data/api/trip_api.dart';
import '../data/models/api_collection.dart';
import '../data/models/trip.dart';
import 'auth_provider.dart';

part 'trip_provider.g.dart';

@riverpod
Future<ApiCollection<Trip>> trips(TripsRef ref, int carId) async {
  // Ensure we are fully authenticated before attempting to fetch trips
  await ref.watch(authProvider.future);
  return ref.watch(tripApiProvider).getTrips(carIri: toIri('cars', carId));
}
