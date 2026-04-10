import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/user.dart';
import 'api_client.dart';

part 'user_api.g.dart';

@riverpod
UserApi userApi(UserApiRef ref) => UserApi(ref.watch(dioProvider));

class UserApi {
  UserApi(this._dio);

  final Dio _dio;

  Future<User> getMe() async {
    final response = await _dio.get<Map<String, dynamic>>('/api/me');
    return User.fromJson(response.data!);
  }

  Future<User> getUser(int id) async {
    final response = await _dio.get<Map<String, dynamic>>('/api/users/$id');
    return User.fromJson(response.data!);
  }

  Future<void> updateLocale(int userId, String locale) async {
    await _dio.patch<void>(
      '/api/users/$userId',
      data: {'locale': locale},
      options: Options(headers: {'Content-Type': 'application/merge-patch+json'}),
    );
  }
}
