import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/api_collection.dart';
import '../models/payment.dart';
import 'api_client.dart';

part 'payment_api.g.dart';

@riverpod
PaymentApi paymentApi(PaymentApiRef ref) => PaymentApi(ref.watch(dioProvider));

class PaymentApi {
  PaymentApi(this._dio);

  final Dio _dio;

  Future<ApiCollection<Payment>> getPayments({
    required String carIri,
    int page = 1,
  }) async {
    final response = await _dio.get<dynamic>(
      '/api/payments',
      queryParameters: {'car': carIri, 'page': page},
    );
    return ApiCollection.fromJson(response.data!, Payment.fromJson);
  }

  Future<Payment> getPayment(int id) async {
    final response = await _dio.get<Map<String, dynamic>>('/api/payments/$id');
    return Payment.fromJson(response.data!);
  }

  Future<Payment> createPayment(Map<String, dynamic> data) async {
    final response = await _dio.post<Map<String, dynamic>>('/api/payments', data: data);
    return Payment.fromJson(response.data!);
  }

  Future<Payment> updatePayment(int id, Map<String, dynamic> data) async {
    final response =
        await _dio.put<Map<String, dynamic>>('/api/payments/$id', data: data);
    return Payment.fromJson(response.data!);
  }

  Future<void> deletePayment(int id) async {
    await _dio.delete<void>('/api/payments/$id');
  }
}
