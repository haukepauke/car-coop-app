import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/constants/app_constants.dart';
import '../../core/errors/api_exception.dart';
import '../models/auth_tokens.dart';
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
    if (options.extra['skip_auth'] == true) {
      handler.next(options);
      return;
    }

    final token = await _storage.read(key: AppConstants.jwtTokenKey);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}

class RefreshTokenInterceptor extends Interceptor {
  RefreshTokenInterceptor({
    required this.storage,
    required this.refreshClient,
    required this.onUnauthorized,
  });

  final FlutterSecureStorage storage;
  final Dio refreshClient;
  final void Function() onUnauthorized;
  Future<String?>? _refreshFuture;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final response = err.response;
    if (response != null && response.statusCode == 401) {
      final options = err.requestOptions;
      final shouldAttemptRefresh =
          !_isRefreshRequest(options) &&
          !_isLoginRequest(options) &&
          options.extra['refresh_attempted'] != true;

      if (shouldAttemptRefresh) {
        final refreshedAccessToken = await _refreshAccessToken();
        if (refreshedAccessToken != null) {
          final retryOptions = options.copyWith(
            headers: Map<String, dynamic>.from(options.headers)
              ..['Authorization'] = 'Bearer $refreshedAccessToken',
            extra: Map<String, dynamic>.from(options.extra)
              ..['refresh_attempted'] = true,
          );

          try {
            final retryResponse = await refreshClient.fetch<dynamic>(retryOptions);
            handler.resolve(retryResponse);
            return;
          } on DioException catch (retryError) {
            handler.reject(_mapException(retryError));
            return;
          }
        }
      }

      await _clearTokens();
      onUnauthorized();
    }

    handler.reject(_mapException(err));
  }

  Future<String?> _refreshAccessToken() async {
    final inFlight = _refreshFuture;
    if (inFlight != null) {
      return inFlight;
    }

    final future = _performRefresh();
    _refreshFuture = future;

    try {
      return await future;
    } finally {
      _refreshFuture = null;
    }
  }

  Future<String?> _performRefresh() async {
    final refreshToken = await storage.read(key: AppConstants.refreshTokenKey);
    if (refreshToken == null || refreshToken.isEmpty) {
      return null;
    }

    try {
      final response = await refreshClient.post<Map<String, dynamic>>(
        '/api/token/refresh',
        data: {'refresh_token': refreshToken},
        options: Options(
          headers: const {'Accept': 'application/json'},
          extra: const {'skip_auth': true, 'refresh_attempted': true},
        ),
      );

      final tokens = AuthTokens.fromJson(response.data!);
      await storage.write(
        key: AppConstants.jwtTokenKey,
        value: tokens.accessToken,
      );
      await storage.write(
        key: AppConstants.refreshTokenKey,
        value: tokens.refreshToken,
      );

      return tokens.accessToken;
    } catch (_) {
      await _clearTokens();
      return null;
    }
  }

  Future<void> _clearTokens() async {
    await storage.delete(key: AppConstants.jwtTokenKey);
    await storage.delete(key: AppConstants.refreshTokenKey);
  }

  bool _isLoginRequest(RequestOptions options) => options.path == '/api/login';

  bool _isRefreshRequest(RequestOptions options) =>
      options.path == '/api/token/refresh';

  DioException _mapException(DioException err) {
    final response = err.response;
    if (response == null) {
      return err;
    }

    return DioException(
      requestOptions: err.requestOptions,
      error: ApiException(
        statusCode: response.statusCode ?? 0,
        message: _extractMessage(response),
      ),
      response: response,
      type: DioExceptionType.badResponse,
    );
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

  final baseOptions = BaseOptions(
    baseUrl: apiUrl,
    headers: {
      'Accept': 'application/json',
    },
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 30),
  );

  final client = Dio(baseOptions);
  final refreshClient = Dio(baseOptions);

  refreshClient.interceptors.addAll([
    AuthInterceptor(storage),
    if (kDebugMode) LogInterceptor(responseBody: false),
  ]);

  client.interceptors.addAll([
    AuthInterceptor(storage),
    RefreshTokenInterceptor(
      storage: storage,
      refreshClient: refreshClient,
      onUnauthorized: () {
        ref.read(jwtTokenProvider.notifier).state = null;
      },
    ),
    if (kDebugMode) LogInterceptor(responseBody: false),
  ]);

  return client;
}
