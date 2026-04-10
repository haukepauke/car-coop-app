import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'api_client.dart';

part 'auth_api.g.dart';

@riverpod
AuthApi authApi(AuthApiRef ref) => AuthApi(ref.watch(dioProvider));

class AuthApi {
  AuthApi(this._dio);

  final Dio _dio;

  /// Returns the JWT token string on success.
  Future<String> login(String email, String password) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/login',
      data: {'email': email, 'password': password},
    );
    return response.data!['token'] as String;
  }
}
