import 'dart:convert';
import 'package:flutter/widgets.dart';
import '../../l10n/app_localizations.dart';

/// Helper to convert a resource name and ID into an API IRI.
String toIri(String resource, int id) => '/api/$resource/$id';

extension StringExtensions on String {
  /// Localizes message board content. If the content is a JSON-encoded system 
  /// message, it replaces placeholders within the localized template.
  String toLocalizedContent(BuildContext context) {
    if (!trim().startsWith('{')) return this;

    try {
      final decoded = jsonDecode(this) as Map<String, dynamic>;
      final key = decoded['key'] as String?;
      final params = decoded['params'] as Map<String, dynamic>? ?? {};

      if (key == null) return this;
      final l10n = AppLocalizations.of(context)!;

      // Use a switch to map server keys to the actual AppLocalizations getters.
      // This keeps the actual text strings in the .arb files where they belong.
      String? template;
      switch (key) {
        case 'board_system.trip_added':
          // These keys are now safely managed in .arb files
          template = l10n.board_system_trip_added;
          break;
        case 'board_system.booking_added':
          template = l10n.board_system_booking_added;
          break;
        case 'board_system.booking_updated':
          template = l10n.board_system_booking_updated;
          break;
        case 'board_system.booking_deleted':
          template = l10n.board_system_booking_deleted;
          break;
        case 'board_system.payment_added':
          template = l10n.board_system_payment_added;
          break;
        case 'board_system.invitation_created':
          template = l10n.board_system_invitation_created;
          break;
        case 'board_system.invitation_accepted':
          template = l10n.board_system_invitation_accepted;
          break;
        case 'board_system.user_removed':
          template = l10n.board_system_user_removed;
          break;
        case 'board_system.price_per_unit_changed':
          template = l10n.board_system_price_per_unit_changed;
          break;
        case 'board_system.milestone_100k':
          template = l10n.board_system_milestone_100k;
          break;
        case 'board_system.milestone_200k':
          template = l10n.board_system_milestone_200k;
          break;
        case 'board_system.milestone_300k':
          template = l10n.board_system_milestone_300k;
          break;
        case 'board_system.milestone_400k':
          template = l10n.board_system_milestone_400k;
          break;
        case 'board_system.milestone_500k':
          template = l10n.board_system_milestone_500k;
          break;
        case 'board_system.milestone_600k':
          template = l10n.board_system_milestone_600k;
          break;
        case 'board_system.milestone_700k':
          template = l10n.board_system_milestone_700k;
          break;
        case 'board_system.milestone_800k':
          template = l10n.board_system_milestone_800k;
          break;
        case 'board_system.milestone_900k':
          template = l10n.board_system_milestone_900k;
          break;
        case 'board_system.milestone_1000k':
          template = l10n.board_system_milestone_1000k;
          break;
        case 'board_system.milestone_repeating':
          template = l10n.board_system_milestone_repeating;
          break;
        // ... add cases for all other keys
        default:
          return this;
      }

      params.forEach((placeholder, value) {
        template = template?.replaceAll(placeholder, value.toString());
      });

      return template ?? this;
    } catch (_) {
      return this;
    }
  }
}