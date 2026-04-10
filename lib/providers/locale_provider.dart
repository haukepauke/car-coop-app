import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'settings_provider.dart';

const _localeKey = 'app_locale';

const supportedLocales = [
  Locale('en'),
  Locale('de'),
  Locale('nl'),
  Locale('fr'),
  Locale('es'),
  Locale('pl'),
];

const localeLabels = {
  'en': 'English',
  'de': 'Deutsch',
  'nl': 'Nederlands',
  'fr': 'Français',
  'es': 'Español',
  'pl': 'Polski',
};

/// Returns the persisted locale code, or null (= use OS locale).
final localCodeProvider = StateProvider<String?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getString(_localeKey);
});

/// The resolved Locale used by MaterialApp.
final localeProvider = Provider<Locale?>((ref) {
  final code = ref.watch(localCodeProvider);
  if (code == null) return null; // let MaterialApp use device locale
  return Locale(code);
});

Future<void> saveLocale(WidgetRef ref, String? code) async {
  final prefs = ref.read(sharedPreferencesProvider);
  if (code == null) {
    await prefs.remove(_localeKey);
  } else {
    await prefs.setString(_localeKey, code);
  }
  ref.read(localCodeProvider.notifier).state = code;
}
