import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/error/failures.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../di/injectable_config.dart';

Future<Result<T>> executeApi<T>(Future<T> Function() apiCall, BuildContext context,) async {
   final lang = AppLocalizations.of(context)!;
  if (!await getIt.get<InternetConnection>().hasInternetAccess) {
    return Error(
      exception: NetworkFailures(
        errorMessage:lang.no_internet,
      ),
    );
  }
  try {
    var result = await apiCall();
    return Success<T>(data: result);
  } on DioException catch (ex) {
    return Error<T>(
      exception: ServerFailure.fromDioException(dioException: ex, lang: lang,),
    );
  } on Exception catch (ex) {
    return Error<T>(exception: ex);
  }
}
