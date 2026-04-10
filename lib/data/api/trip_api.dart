import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/api_collection.dart';
import '../models/trip.dart';
import 'api_client.dart';

part 'trip_api.g.dart';

@riverpod
TripApi tripApi(TripApiRef ref) => TripApi(ref.watch(dioProvider));

class TripApi {
  TripApi(this._dio);

  final Dio _dio;

  Future<ApiCollection<Trip>> getTrips({
    required String carIri,
    int page = 1,
  }) async {
    final response = await _dio.get<dynamic>(
      '/api/trips',
      queryParameters: {'car': carIri, 'page': page},
    );
    return ApiCollection.fromJson(response.data!, Trip.fromJson);
  }

  Future<Trip> getTrip(int id) async {
    final response = await _dio.get<Map<String, dynamic>>('/api/trips/$id');
    return Trip.fromJson(response.data!);
  }

  Future<Trip> createTrip(Map<String, dynamic> data) async {
    final response = await _dio.post<Map<String, dynamic>>('/api/trips', data: data);
    return Trip.fromJson(response.data!);
  }

  Future<Trip> updateTrip(int id, Map<String, dynamic> data) async {
    final response = await _dio.put<Map<String, dynamic>>('/api/trips/$id', data: data);
    return Trip.fromJson(response.data!);
  }

  Future<void> deleteTrip(int id) async {
    await _dio.delete<void>('/api/trips/$id');
  }
}
