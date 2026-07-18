import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';

class FirebaseExceptionHandler implements Exception {
  final String message;

  FirebaseExceptionHandler._(this.message);

  factory FirebaseExceptionHandler.fromFirestore({
    required FirebaseException exception,
    required AppLocalizations localizations,
  }) {
    switch (exception.code) {
      case 'permission-denied':
        return FirebaseExceptionHandler._(
          localizations.firebase_permission_denied,
        );

      case 'not-found':
        return FirebaseExceptionHandler._(
          localizations.firebase_document_not_found,
        );

      case 'unavailable':
        return FirebaseExceptionHandler._(
          localizations.firebase_service_unavailable,
        );

      case 'deadline-exceeded':
        return FirebaseExceptionHandler._(
          localizations.firebase_request_timeout,
        );

      case 'cancelled':
        return FirebaseExceptionHandler._(
          localizations.firebase_operation_cancelled,
        );

      case 'already-exists':
        return FirebaseExceptionHandler._(
          localizations.firebase_document_already_exists,
        );

      case 'resource-exhausted':
        return FirebaseExceptionHandler._(
          localizations.firebase_quota_exceeded,
        );

      case 'unauthenticated':
        return FirebaseExceptionHandler._(
          localizations.firebase_authentication_required,
        );

      case 'invalid-argument':
        return FirebaseExceptionHandler._(
          localizations.firebase_invalid_argument,
        );

      default:
        return FirebaseExceptionHandler._(
          exception.message ??
              localizations.unknown_firebase_error,
        );
    }
  }

  @override
  String toString() => message;
}