import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

enum AppMessageType {
  info,
  success,
  warning,
  error,
}

Future<void> showAppMessageDialog(
  BuildContext context, {
  required String message,
  AppMessageType type = AppMessageType.info,
  String? title,
}) {
  final l10n = AppLocalizations.of(context)!;
  final colorScheme = Theme.of(context).colorScheme;

  final (icon, color) = switch (type) {
    AppMessageType.info => (Icons.info_outline, colorScheme.primary),
    AppMessageType.success => (Icons.check_circle_outline, Colors.green.shade700),
    AppMessageType.warning => (Icons.warning_amber_outlined, Colors.orange.shade800),
    AppMessageType.error => (Icons.error_outline, colorScheme.error),
  };

  return showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      icon: Icon(icon, size: 40, color: color),
      title: title != null ? Text(title, textAlign: TextAlign.center) : null,
      content: Text(message, textAlign: TextAlign.center),
      actions: [
        FilledButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: Text(l10n.ok),
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
    ),
  );
}
