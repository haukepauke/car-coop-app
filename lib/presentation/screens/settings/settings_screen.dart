import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data/api/user_api.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/car_provider.dart';
import '../../../providers/locale_provider.dart';
import '../../../providers/settings_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  Future<void> _changeLocale(String? code) async {
    if (code == null) return;
    await saveLocale(ref, code);
    final user = ref.read(currentUserProvider);
    if (user != null) {
      try {
        await ref.read(userApiProvider).updateLocale(user.id, code);
      } catch (_) {
        // Server update is best-effort; local change still applies.
      }
    }
  }

  Future<void> _logout() async {
    await ref.read(authProvider.notifier).logout();
    if (mounted) context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final quickActionsEnabled = ref.watch(quickActionsEnabledProvider);
    final currentUser = ref.watch(currentUserProvider);
    final localeCode = ref.watch(localCodeProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        children: [
          if (currentUser != null)
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(currentUser.name),
              subtitle: Text(currentUser.email),
            ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.dark_mode_outlined),
            title: Text(l10n.settingsTheme),
            trailing: DropdownButton<ThemeMode>(
              value: themeMode,
              underline: const SizedBox(),
              items: [
                DropdownMenuItem(value: ThemeMode.system, child: Text(l10n.settingsThemeSystem)),
                DropdownMenuItem(value: ThemeMode.light, child: Text(l10n.settingsThemeLight)),
                DropdownMenuItem(value: ThemeMode.dark, child: Text(l10n.settingsThemeDark)),
              ],
              onChanged: (mode) {
                if (mode != null) saveThemeMode(ref, mode);
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(l10n.settingsLanguage),
            trailing: DropdownButton<String>(
              value: localeCode ?? 'en',
              underline: const SizedBox(),
              items: localeLabels.entries
                  .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
                  .toList(),
              onChanged: _changeLocale,
            ),
          ),
          const Divider(),
          SwitchListTile(
            secondary: const Icon(Icons.bolt_outlined),
            title: Text(l10n.settingsQuickActions),
            value: quickActionsEnabled,
            onChanged: (value) => saveQuickActionsEnabled(ref, value),
          ),
          const Divider(),
          ref.watch(carsProvider).maybeWhen(
            data: (collection) {
              if (collection.members.length < 2) return const SizedBox.shrink();
              return ListTile(
                leading: const Icon(Icons.directions_car_outlined),
                title: Text(l10n.settingsSwitchCar),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  ref.read(selectedCarIdProvider.notifier).state = null;
                  context.go('/cars');
                },
              );
            },
            orElse: () => const SizedBox.shrink(),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: Text(l10n.signOut, style: const TextStyle(color: Colors.red)),
            onTap: _logout,
          ),
        ],
      ),
    );
  }
}
