import 'package:dio/dio.dart';
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
    // 1. Watch the token provider. This makes the AuthNotifier reactive to login/logout.
    final token = ref.watch(jwtTokenProvider);

    // 2. Initial boot: If state is null, try to restore from secure storage.
    if (token == null) {
      final storage = ref.read(secureStorageProvider);
      final persistedToken = await storage.read(key: AppConstants.jwtTokenKey);
      if (persistedToken != null) {
        // Sync the token provider. This will trigger this build() method to run again.
        // Future.microtask ensures we don't update state during the build phase.
        Future.microtask(() => ref.read(jwtTokenProvider.notifier).state = persistedToken);
      }
      return null;
    }

    try {
      // 3. Fetch user profile.
      final user = await ref.watch(userApiProvider).getMe();
      _applyUserLocale(user);
      return user;
    } catch (e) {
      // 4. Handle Auth errors. By returning null instead of rethrowing,
      // we suppress technical UI errors and allow the system to settle.
      final errorStr = e.toString().toLowerCase();
      if (errorStr.contains('401') || errorStr.contains('jwt') || errorStr.contains('token')) {
        // Only delete from storage if we actually have a token that was rejected
        final storage = ref.read(secureStorageProvider);
        if (token != null) {
          await storage.delete(key: AppConstants.jwtTokenKey);
          ref.read(jwtTokenProvider.notifier).state = null;
        }
        return null;
      }
      
      // For other errors (timeouts, 500s), rethrow so the UI shows an error state 
      // with a "Retry" button instead of logging the user out.
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final token = await ref.read(authApiProvider).login(email, password);
      await ref.read(secureStorageProvider).write(key: AppConstants.jwtTokenKey, value: token);
      
      // Updating this triggers build() reactively.
      ref.read(jwtTokenProvider.notifier).state = token;
      // Return the result of the reactive build loop
      return await future;
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
