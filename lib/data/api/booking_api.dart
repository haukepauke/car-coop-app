import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/api_collection.dart';
import '../models/booking.dart';
import 'api_client.dart';

part 'booking_api.g.dart';

@riverpod
BookingApi bookingApi(BookingApiRef ref) => BookingApi(ref.watch(dioProvider));

class BookingApi {
  BookingApi(this._dio);

  final Dio _dio;

  Future<ApiCollection<Booking>> getBookings({
    required String carIri,
    int page = 1,
  }) async {
    final response = await _dio.get<dynamic>(
      '/api/bookings',
      queryParameters: {
        'car': carIri,
        'page': page,
        'order[startDate]': 'desc',
      },
    );
    return ApiCollection.fromJson(response.data!, Booking.fromJson);
  }

  Future<Booking> getBooking(int id) async {
    final response = await _dio.get<Map<String, dynamic>>('/api/bookings/$id');
    return Booking.fromJson(response.data!);
  }

  Future<Booking> createBooking(Map<String, dynamic> data) async {
    final response = await _dio.post<Map<String, dynamic>>('/api/bookings', data: data);
    return Booking.fromJson(response.data!);
  }

  Future<Booking> updateBooking(int id, Map<String, dynamic> data) async {
    final response = await _dio.put<Map<String, dynamic>>('/api/bookings/$id', data: data);
    return Booking.fromJson(response.data!);
  }

  Future<void> deleteBooking(int id) async {
    await _dio.delete<void>('/api/bookings/$id');
  }
}
