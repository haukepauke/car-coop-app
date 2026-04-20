import 'dart:convert';
import 'dart:typed_data';

import 'package:car_coop_app/core/constants/app_constants.dart';
import 'package:car_coop_app/data/api/api_client.dart';
import 'package:car_coop_app/data/api/auth_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AuthApi', () {
    test('login parses access and refresh tokens', () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://car-coop.test'));
      dio.httpClientAdapter = _FakeAdapter((options) async {
        expect(options.path, '/api/login');

        return _jsonResponse(
          200,
          {'token': 'access-1', 'refresh_token': 'refresh-1'},
        );
      });

      final tokens = await AuthApi(dio).login('alice@example.com', 'secret');

      expect(tokens.accessToken, 'access-1');
      expect(tokens.refreshToken, 'refresh-1');
    });

    test('login remains compatible when refresh token is absent', () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://car-coop.test'));
      dio.httpClientAdapter = _FakeAdapter((options) async {
        expect(options.path, '/api/login');

        return _jsonResponse(200, {'token': 'legacy-access'});
      });

      final tokens = await AuthApi(dio).login('alice@example.com', 'secret');

      expect(tokens.accessToken, 'legacy-access');
      expect(tokens.refreshToken, isNull);
    });
  });

  group('RefreshTokenInterceptor', () {
    test('refreshes tokens and retries the failed request', () async {
      final storage = _MemorySecureStorage({
        AppConstants.jwtTokenKey: 'expired-access',
        AppConstants.refreshTokenKey: 'refresh-1',
      });

      var unauthorizedCalls = 0;
      final seenAuthorizations = <String?>[];

      final adapter = _FakeAdapter((options) async {
        if (options.path == '/api/token/refresh') {
          expect(options.headers.containsKey('Authorization'), isFalse);
          expect(options.data, {'refresh_token': 'refresh-1'});

          return _jsonResponse(200, {
            'token': 'fresh-access',
            'refresh_token': 'refresh-2',
          });
        }

        if (options.path == '/api/cars') {
          seenAuthorizations.add(options.headers['Authorization'] as String?);

          if (options.headers['Authorization'] == 'Bearer fresh-access') {
            return _jsonResponse(200, {'member': []});
          }

          return _jsonResponse(401, {'message': 'Expired JWT token'});
        }

        return _jsonResponse(404, {'message': 'Not found'});
      });

      final client = _buildClient(
        storage: storage,
        adapter: adapter,
        onUnauthorized: () => unauthorizedCalls++,
      );

      final response = await client.get<Map<String, dynamic>>('/api/cars');

      expect(response.statusCode, 200);
      expect(seenAuthorizations, ['Bearer expired-access', 'Bearer fresh-access']);
      expect(
        await storage.read(key: AppConstants.jwtTokenKey),
        'fresh-access',
      );
      expect(
        await storage.read(key: AppConstants.refreshTokenKey),
        'refresh-2',
      );
      expect(unauthorizedCalls, 0);
    });

    test('clears tokens and triggers unauthorized when refresh fails', () async {
      final storage = _MemorySecureStorage({
        AppConstants.jwtTokenKey: 'expired-access',
        AppConstants.refreshTokenKey: 'refresh-1',
      });

      var unauthorizedCalls = 0;

      final adapter = _FakeAdapter((options) async {
        if (options.path == '/api/token/refresh') {
          return _jsonResponse(401, {'message': 'Invalid refresh token'});
        }

        if (options.path == '/api/cars') {
          return _jsonResponse(401, {'message': 'Expired JWT token'});
        }

        return _jsonResponse(404, {'message': 'Not found'});
      });

      final client = _buildClient(
        storage: storage,
        adapter: adapter,
        onUnauthorized: () => unauthorizedCalls++,
      );

      await expectLater(
        client.get<Map<String, dynamic>>('/api/cars'),
        throwsA(isA<DioException>()),
      );

      expect(await storage.read(key: AppConstants.jwtTokenKey), isNull);
      expect(await storage.read(key: AppConstants.refreshTokenKey), isNull);
      expect(unauthorizedCalls, 1);
    });

    test('falls back to logout behavior when no refresh token exists', () async {
      final storage = _MemorySecureStorage({
        AppConstants.jwtTokenKey: 'legacy-access',
      });

      var unauthorizedCalls = 0;

      final adapter = _FakeAdapter((options) async {
        if (options.path == '/api/cars') {
          return _jsonResponse(401, {'message': 'Expired JWT token'});
        }

        fail('Unexpected request to ${options.path}');
      });

      final client = _buildClient(
        storage: storage,
        adapter: adapter,
        onUnauthorized: () => unauthorizedCalls++,
      );

      await expectLater(
        client.get<Map<String, dynamic>>('/api/cars'),
        throwsA(isA<DioException>()),
      );

      expect(await storage.read(key: AppConstants.jwtTokenKey), isNull);
      expect(await storage.read(key: AppConstants.refreshTokenKey), isNull);
      expect(unauthorizedCalls, 1);
    });
  });
}

Dio _buildClient({
  required FlutterSecureStorage storage,
  required HttpClientAdapter adapter,
  required void Function() onUnauthorized,
}) {
  final baseOptions = BaseOptions(
    baseUrl: 'https://car-coop.test',
    headers: const {'Accept': 'application/json'},
  );

  final client = Dio(baseOptions)..httpClientAdapter = adapter;
  final refreshClient = Dio(baseOptions)..httpClientAdapter = adapter;

  refreshClient.interceptors.add(AuthInterceptor(storage));
  client.interceptors.addAll([
    AuthInterceptor(storage),
    RefreshTokenInterceptor(
      storage: storage,
      refreshClient: refreshClient,
      onUnauthorized: onUnauthorized,
    ),
  ]);

  return client;
}

ResponseBody _jsonResponse(int statusCode, Map<String, dynamic> body) {
  return ResponseBody.fromString(
    jsonEncode(body),
    statusCode,
    headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    },
  );
}

class _FakeAdapter implements HttpClientAdapter {
  _FakeAdapter(this._handler);

  final Future<ResponseBody> Function(RequestOptions options) _handler;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    return _handler(options);
  }

  @override
  void close({bool force = false}) {}
}

class _MemorySecureStorage extends FlutterSecureStorage {
  _MemorySecureStorage([Map<String, String>? initialValues])
      : _values = Map<String, String>.from(initialValues ?? const {});

  final Map<String, String> _values;

  @override
  Future<String?> read({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    return _values[key];
  }

  @override
  Future<void> write({
    required String key,
    required String? value,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    if (value == null) {
      _values.remove(key);
      return;
    }

    _values[key] = value;
  }

  @override
  Future<void> delete({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    _values.remove(key);
  }
}
