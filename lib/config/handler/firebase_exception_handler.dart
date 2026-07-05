import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseExceptionHandler implements Exception {
  final String message;

  FirebaseExceptionHandler._(this.message);

  factory FirebaseExceptionHandler.fromFirestore(FirebaseException exception) {
    switch (exception.code) {
      case 'permission-denied':
        return FirebaseExceptionHandler._(
          'You do not have permission to perform this action.',
        );

      case 'not-found':
        return FirebaseExceptionHandler._(
          'Requested document was not found.',
        );

      case 'unavailable':
        return FirebaseExceptionHandler._(
          'Firebase service is currently unavailable.',
        );

      case 'deadline-exceeded':
        return FirebaseExceptionHandler._(
          'The request timed out. Please try again.',
        );

      case 'cancelled':
        return FirebaseExceptionHandler._(
          'The operation was cancelled.',
        );

      case 'already-exists':
        return FirebaseExceptionHandler._(
          'The document already exists.',
        );

      case 'resource-exhausted':
        return FirebaseExceptionHandler._(
          'Firebase quota has been exceeded.',
        );

      case 'unauthenticated':
        return FirebaseExceptionHandler._(
          'Authentication is required.',
        );

      case 'invalid-argument':
        return FirebaseExceptionHandler._(
          'An invalid argument was provided.',
        );

      default:
        return FirebaseExceptionHandler._(
          exception.message ?? 'An unknown Firebase error occurred.',
        );
    }
  }

  @override
  String toString() => message;
}