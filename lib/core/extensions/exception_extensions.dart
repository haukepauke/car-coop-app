import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import '../errors/api_exception.dart';
import '../../l10n/app_localizations.dart';

extension ExceptionExtensions on Object {
  /// Maps an exception (specifically DioException) to a user-friendly localized string.
  String toLocalizedMessage(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (this is DioException) {
      final error = this as DioException;
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.connectionError:
          return l10n.retry;
        case DioExceptionType.badResponse:
          final apiError = error.error;
          if (apiError is ApiException && apiError.message.trim().isNotEmpty) {
            return _localizeApiMessage(apiError.message, l10n);
          }
          final statusCode = error.response?.statusCode;
          if (statusCode == 401 || error.toString().contains('401')) {
            return l10n.invalidCredentials;
          } else if (statusCode == 403) {
            return l10n.notSet;
          } else if (statusCode != null && statusCode >= 500) {
            return l10n.retry;
          }
          return "${l10n.appTitle}: ${statusCode ?? 'unknown'}";
        case DioExceptionType.cancel:
          return l10n.cancel;
        default:
          return l10n.retry;
      }
    }

    // Fallback for non-Dio errors that contain auth-related keywords
    final errorStr = toString().toUpperCase();
    if (errorStr.contains('401') || errorStr.contains('JWT') || errorStr.contains('TOKEN') || errorStr.contains('UNAUTHORIZED')) {
      return l10n.invalidCredentials;
    }


    return toString();
  }

  String _localizeApiMessage(String message, AppLocalizations l10n) {
    final trimmed = message.trim();
    final previousTripDate = RegExp(r'(\d{2}\.\d{2}\.\d{4})').firstMatch(trimmed)?.group(1);
    final lower = trimmed.toLowerCase();

    if (lower.contains('previous trip') || lower.contains('trip.date.before_previous')) {
      return l10n.tripStartDateMustNotBeBeforePreviousEnd(
        previousTripDate ?? l10n.notSet,
      );
    }

    return trimmed;
  }
}
