import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/extensions/string_extensions.dart';
import '../data/api/parking_api.dart';
import '../data/models/api_collection.dart';
import '../data/models/parking_location.dart';

part 'parking_provider.g.dart';

@riverpod
Future<ApiCollection<ParkingLocation>> parkingLocations(
  ParkingLocationsRef ref,
  int carId,
) async {
  return ref
      .watch(parkingApiProvider)
      .getParkingLocations(carIri: toIri('cars', carId));
}
