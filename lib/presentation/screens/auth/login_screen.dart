import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../l10n/app_localizations.dart';
import '../../../core/extensions/exception_extensions.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/locale_provider.dart';
import '../../../providers/settings_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(authProvider.notifier).login(
          _emailController.text.trim(),
          _passwordController.text,
        );
    // Navigation is handled by the router's refreshListenable redirect.
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState.isLoading;
    final l10n = AppLocalizations.of(context)!;

    ref.listen(authProvider, (_, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!.toLocalizedMessage(context)),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipOval(
                child: Image.asset('assets/images/logo_round.png', width: 96, height: 96),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.appTitle,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Form(
                key: _formKey,
                child: AutofillGroup(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: const [AutofillHints.email],
                        decoration: InputDecoration(
                          labelText: l10n.email,
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                        validator: (v) =>
                            v == null || v.isEmpty ? l10n.emailRequired : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        autofillHints: const [AutofillHints.password],
                        decoration: InputDecoration(
                          labelText: l10n.password,
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                            onPressed: () =>
                                setState(() => _obscurePassword = !_obscurePassword),
                          ),
                        ),
                        validator: (v) =>
                            v == null || v.isEmpty ? l10n.passwordRequired : null,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: isLoading ? null : _login,
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(l10n.signIn),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () {
                  final base = (ref.read(apiUrlProvider) ?? 'https://app.car-coop.net')
                      .replaceAll(RegExp(r'/$'), '');
                  launchUrl(
                    Uri.parse('$base/en/register'),
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: Text(l10n.registerNewAccount),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => context.go('/setup'),
                child: Text(l10n.changeServerUrl),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.language, size: 18),
                  const SizedBox(width: 8),
                  DropdownButton<String>(
                    value: ref.watch(localCodeProvider) ??
                        WidgetsBinding.instance.platformDispatcher.locale.languageCode,
                    underline: const SizedBox(),
                    items: localeLabels.entries
                        .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
                        .toList(),
                    onChanged: (code) {
                      if (code != null) saveLocale(ref, code);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
