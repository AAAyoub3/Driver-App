import 'package:dio/dio.dart';
import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/config/api/app_endpoints.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../api/app_interceptors.dart';

@module
abstract class CoreInjectableModule {
  @preResolve
  Future<SharedPreferences> prefs() => SharedPreferences.getInstance();

  @lazySingleton
  FlutterSecureStorage secureStorage() => FlutterSecureStorage();

  @singleton
  Dio dio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppEndPoints.baseUrl,
        sendTimeout: Duration(seconds: 45),
        connectTimeout: Duration(seconds: 45),
      ),
    );
    dio.interceptors.add(AuthInterceptor(dio: dio, fss: secureStorage()));
    dio.interceptors.addAll([
      if (kDebugMode)
        PrettyDioLogger(
          request: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
          compact: true,
          requestHeader: true,
        ),
    ]);
    return dio;
  }

  @Named(Apikeys.fcm)
  @lazySingleton
  Dio fcmDio() {
    return Dio(BaseOptions(baseUrl: AppEndPoints.notificationbaseUrl));
  }

  @lazySingleton
  CancelToken cancelToken() => CancelToken();

  @lazySingleton
  InternetConnection internetConnection() => InternetConnection();
}
