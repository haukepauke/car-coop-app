import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/constants/app_constants.dart';
import '../../core/errors/api_exception.dart';
import '../../providers/settings_provider.dart';

part 'api_client.g.dart';

// ---------------------------------------------------------------------------
// Auth interceptor – injects Bearer token on every request
// ---------------------------------------------------------------------------
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._storage);

  final FlutterSecureStorage _storage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.read(key: AppConstants.jwtTokenKey);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}

// ---------------------------------------------------------------------------
// Error interceptor – maps HTTP errors to ApiException
// On 401: clears the stored token and invokes [onUnauthorized] callback
// (the router will redirect once jwtTokenProvider changes)
// ---------------------------------------------------------------------------
class ErrorInterceptor extends Interceptor {
  ErrorInterceptor(this._storage, this._onUnauthorized);

  final FlutterSecureStorage _storage;
  final void Function() _onUnauthorized;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;
    if (response != null) {
      if (response.statusCode == 401) {
        _storage.delete(key: AppConstants.jwtTokenKey);
        _onUnauthorized();
      }
      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: ApiException(
            statusCode: response.statusCode ?? 0,
            message: _extractMessage(response),
          ),
          response: response,
          type: DioExceptionType.badResponse,
        ),
      );
    } else {
      handler.next(err);
    }
  }

  String _extractMessage(Response<dynamic> response) {
    try {
      final data = response.data;
      if (data is Map) {
        return (data['hydra:description'] ?? data['detail'] ?? data['message'] ?? '')
            .toString();
      }
    } catch (_) {}
    return response.statusMessage ?? 'Unknown error';
  }
}

// ---------------------------------------------------------------------------
// Providers
// ---------------------------------------------------------------------------
@riverpod
FlutterSecureStorage secureStorage(SecureStorageRef ref) {
  return const FlutterSecureStorage();
}

@riverpod
Dio dio(DioRef ref) {
  final apiUrl = ref.watch(apiUrlProvider) ?? '';
  final storage = ref.watch(secureStorageProvider);

  final client = Dio(
    BaseOptions(
      baseUrl: apiUrl,
      headers: {
        'Accept': 'application/json',
      },
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  client.interceptors.addAll([
    AuthInterceptor(storage),
    ErrorInterceptor(storage, () {
      // Setting jwtTokenProvider to null triggers the go_router redirect guard
      // to push the user to /login on the next navigation cycle.
      ref.read(jwtTokenProvider.notifier).state = null;
    }),
    LogInterceptor(responseBody: false),
  ]);

  return client;
}
