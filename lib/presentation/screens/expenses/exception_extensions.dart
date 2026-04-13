import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
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
          return "Network error. Please check your connection."; // Map to l10n.networkError
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          if (statusCode == 401) {
            return "Session expired. Please log in again."; // Map to l10n.authError
          } else if (statusCode == 403) {
            return "Access denied."; // Map to l10n.forbiddenError
          } else if (statusCode >= 500) {
            return "Server error. Please try again later."; // Map to l10n.serverError
          }
          return "Request failed ($statusCode).";
        case DioExceptionType.cancel:
          return "Request cancelled.";
        default:
          return "An unexpected error occurred."; // Map to l10n.errorOccurred
      }
    }
    return toString();
  }
}