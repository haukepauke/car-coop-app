import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/api/user_api.dart';
import '../data/models/user.dart';

part 'user_provider.g.dart';

@riverpod
Future<User> userDetail(UserDetailRef ref, int userId) async {
  return ref.watch(userApiProvider).getUser(userId);
}
