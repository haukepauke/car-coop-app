import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'api_client.dart';
import '../models/auth_tokens.dart';

part 'auth_api.g.dart';

@riverpod
AuthApi authApi(AuthApiRef ref) => AuthApi(ref.watch(dioProvider));

class AuthApi {
  AuthApi(this._dio);

  final Dio _dio;

  Future<AuthTokens> login(String email, String password) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/login',
      data: {'email': email, 'password': password},
    );

    return AuthTokens.fromJson(response.data!);
  }

  Future<void> logout(String refreshToken) async {
    await _dio.post<void>(
      '/api/logout',
      data: {'refresh_token': refreshToken},
    );
  }
}
