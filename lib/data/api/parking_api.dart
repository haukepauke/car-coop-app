import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/api_collection.dart';
import '../models/parking_location.dart';
import 'api_client.dart';

part 'parking_api.g.dart';

@riverpod
ParkingApi parkingApi(ParkingApiRef ref) => ParkingApi(ref.watch(dioProvider));

class ParkingApi {
  ParkingApi(this._dio);

  final Dio _dio;

  Future<ApiCollection<ParkingLocation>> getParkingLocations({
    required String carIri,
    int page = 1,
  }) async {
    final response = await _dio.get<dynamic>(
      '/api/parking_locations',
      queryParameters: {'car': carIri, 'page': page},
    );
    return ApiCollection.fromJson(response.data!, ParkingLocation.fromJson);
  }

  Future<ParkingLocation> createParkingLocation(Map<String, dynamic> data) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/parking_locations',
      data: data,
    );
    return ParkingLocation.fromJson(response.data!);
  }
}
