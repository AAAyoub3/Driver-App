
import 'package:flowery/config/error/failures.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';

String? handleError(Exception? exception, AppLocalizations lang) {
  return switch (exception) {
    ServerFailure() => exception.errorMessage,
    OfflineFailures() => exception.errorMessage,
    CacheFailures() => exception.errorMessage,
    _ => lang.connectionError,
  };
}

bool handleNetwork(Exception? exception, AppLocalizations lang) {
  return switch (exception) {
    ServerFailure()
        when connectionErrorsList(lang).contains(exception.errorMessage) =>
      true,
    NetworkFailures() => true,
    _ => false,
  };
}
