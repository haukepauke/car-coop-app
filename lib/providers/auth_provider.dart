import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/app_constants.dart';
import '../data/api/api_client.dart';
import '../data/api/auth_api.dart';
import '../data/api/user_api.dart';
import '../data/models/user.dart';
import 'locale_provider.dart';
import 'settings_provider.dart';

// jwtTokenProvider is defined in settings_provider.dart

class AuthNotifier extends AsyncNotifier<User?> {
  @override
  Future<User?> build() async {
    final storage = ref.watch(secureStorageProvider);
    final token = await storage.read(key: AppConstants.jwtTokenKey);
    if (token == null) return null;
    ref.read(jwtTokenProvider.notifier).state = token;
    try {
      final user = await ref.watch(userApiProvider).getMe();
      _applyUserLocale(user);
      return user;
    } catch (_) {
      // Token is invalid or expired — clear it so the login form works cleanly.
      await storage.delete(key: AppConstants.jwtTokenKey);
      ref.read(jwtTokenProvider.notifier).state = null;
      return null;
    }
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final token = await ref.read(authApiProvider).login(email, password);
      final storage = ref.read(secureStorageProvider);
      await storage.write(key: AppConstants.jwtTokenKey, value: token);
      ref.read(jwtTokenProvider.notifier).state = token;
      final user = await ref.read(userApiProvider).getMe();
      _applyUserLocale(user);
      return user;
    });
  }

  void _applyUserLocale(User user) {
    if (user.locale != null) {
      ref.read(localCodeProvider.notifier).state = user.locale;
    }
  }

  Future<void> logout() async {
    final storage = ref.read(secureStorageProvider);
    await storage.delete(key: AppConstants.jwtTokenKey);
    ref.read(jwtTokenProvider.notifier).state = null;
    state = const AsyncData(null);
  }
}

final authProvider = AsyncNotifierProvider<AuthNotifier, User?>(AuthNotifier.new);

final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authProvider).valueOrNull;
});
