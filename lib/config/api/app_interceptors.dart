import 'package:dio/dio.dart';
import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/config/api/status_code.dart';
import 'package:flowery/config/di/injectable_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthInterceptor extends Interceptor {
  final Dio dio;
  final FlutterSecureStorage fss;

  AuthInterceptor({required this.dio, required this.fss});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.cancelToken = getIt<CancelToken>();
    String? authToken = await fss.read(key: Apikeys.accessToken);
    authToken = (authToken != null && authToken.isNotEmpty)
        ? authToken
        : 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkcml2ZXIiOiI2YTM4NDVhYjk5MjYxMmFlNTk5YjE3MzYiLCJpYXQiOjE3ODM3MjU1ODF9.2NbfpF9nSOhPKtyE12RB72MeKYfXlain__U5Z2R6OPw'; // TODO: remove before release
    options.headers['Authorization'] = '${Apikeys.bearer} $authToken';
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // ToDo
    super.onResponse(response, handler);
  }
}
