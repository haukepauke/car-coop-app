import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/extensions/string_extensions.dart';
import '../data/api/payment_api.dart';
import '../data/models/api_collection.dart';
import '../data/models/payment.dart';

part 'payment_provider.g.dart';

@riverpod
Future<ApiCollection<Payment>> payments(PaymentsRef ref, int carId) async {
  return ref.watch(paymentApiProvider).getPayments(carIri: toIri('cars', carId));
}
