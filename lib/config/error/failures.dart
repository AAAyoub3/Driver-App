import 'package:dio/dio.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';


sealed class Failures implements Exception {
  final String errorMessage;
  

  const Failures({required this.errorMessage});
}

class ServerFailure extends Failures {
  const ServerFailure({required super.errorMessage});

  factory ServerFailure.fromDioException({required DioException dioException,required AppLocalizations lang,}) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          errorMessage:  lang.connectionTimeout,
        );
      case DioExceptionType.sendTimeout:
        return ServerFailure(
          errorMessage: lang.sendTimeout,
        );

      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          errorMessage: lang.receiveTimeout,
        );
      case DioExceptionType.badCertificate:
        return ServerFailure(
          errorMessage:  lang.badCertificate,
        );
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          statusCode: dioException.response?.statusCode,
          response: dioException.response?.data,
          lang: lang,
        );

      case DioExceptionType.cancel:
        return ServerFailure(
          errorMessage:  lang.cancelled,
        );
      case DioExceptionType.connectionError:
        return ServerFailure(
          errorMessage:  lang.connectionError,
        );
      case DioExceptionType.unknown:
        return ServerFailure(
          errorMessage:  lang.unknown,
        );
    }
  }

  factory ServerFailure.fromResponse({int? statusCode, dynamic response,required AppLocalizations lang}) {
    if (statusCode == 400 ||
        statusCode == 401 ||
        statusCode == 422 ||
        statusCode == 409 ||
        statusCode == 424 ||
        statusCode == 404) {
      return ServerFailure(
        errorMessage:
            response['message'] ??  lang.sendTimeout,
      );
    } else if (statusCode == 500) {
      return ServerFailure(
        errorMessage: lang.server_error,
      );
    } else if (statusCode == 403) {
      //    Helper.expiredToken();

      // return the server failure instead of throw it
      return ServerFailure(
        errorMessage: lang.expiredToken,
      );
    } else {
      return ServerFailure(
        errorMessage:lang.unknown,
      );
    }
  }
}

class OfflineFailures extends Failures {
  const OfflineFailures({required super.errorMessage});
}

class CacheFailures extends Failures {
  const CacheFailures({required super.errorMessage});
}

class NetworkFailures extends Failures {
  const NetworkFailures({required super.errorMessage});
}

List<String> connectionErrorsList (AppLocalizations lang) =>[
 lang.connectionError,
 lang.connectionTimeout,
 lang.receiveTimeout,
 lang.sendTimeout,
];
