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
    // if (authToken != null && authToken.isNotEmpty) {
    // options.headers['Authorization'] = 'Bearer $authToken';
    options.headers['Authorization'] =
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkcml2ZXIiOiI2YTNiZTk2NTk5MjYxMmFlNTk5YjNkODQiLCJpYXQiOjE3ODM2MDg4Mjd9.c0PDE_sx1oUFR3Xaz33zp2zMauBX188N4ycL0lUsOPU';
    // }
    print(options.headers);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // ToDo
    super.onResponse(response, handler);
  }
}
