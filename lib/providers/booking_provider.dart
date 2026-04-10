import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/extensions/string_extensions.dart';
import '../data/api/booking_api.dart';
import '../data/models/api_collection.dart';
import '../data/models/booking.dart';

part 'booking_provider.g.dart';

@riverpod
Future<ApiCollection<Booking>> bookings(BookingsRef ref, int carId) async {
  return ref.watch(bookingApiProvider).getBookings(carIri: toIri('cars', carId));
}
