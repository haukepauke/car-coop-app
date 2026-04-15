import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/constants/app_constants.dart';

// ---------------------------------------------------------------------------
// SharedPreferences instance provider
// ---------------------------------------------------------------------------
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Override in ProviderScope');
});

// ---------------------------------------------------------------------------
// JWT token (in-memory state; source of truth is flutter_secure_storage)
// Stored here (not in auth_provider) so api_client.dart can clear it on 401
// without creating a circular import.
// ---------------------------------------------------------------------------
final jwtTokenProvider = StateProvider<String?>((ref) => null);

// ---------------------------------------------------------------------------
// API URL
// ---------------------------------------------------------------------------
final apiUrlProvider = StateProvider<String?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getString(AppConstants.apiUrlKey);
});

Future<void> saveApiUrl(WidgetRef ref, String url) async {
  final prefs = ref.read(sharedPreferencesProvider);
  await prefs.setString(AppConstants.apiUrlKey, url);
  ref.read(apiUrlProvider.notifier).state = url;
}

// ---------------------------------------------------------------------------
// Theme mode
// ---------------------------------------------------------------------------
final themeModeProvider = StateProvider<ThemeMode>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final stored = prefs.getString(AppConstants.themeModeKey);
  return switch (stored) {
    'dark' => ThemeMode.dark,
    'light' => ThemeMode.light,
    _ => ThemeMode.light,
  };
});

Future<void> saveThemeMode(WidgetRef ref, ThemeMode mode) async {
  final prefs = ref.read(sharedPreferencesProvider);
  await prefs.setString(AppConstants.themeModeKey, mode.name);
  ref.read(themeModeProvider.notifier).state = mode;
}

// ---------------------------------------------------------------------------
// Quick actions
// ---------------------------------------------------------------------------
final quickActionsEnabledProvider = StateProvider<bool>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getBool(AppConstants.quickActionsEnabledKey) ?? true;
});

Future<void> saveQuickActionsEnabled(WidgetRef ref, bool enabled) async {
  final prefs = ref.read(sharedPreferencesProvider);
  await prefs.setBool(AppConstants.quickActionsEnabledKey, enabled);
  ref.read(quickActionsEnabledProvider.notifier).state = enabled;
}
