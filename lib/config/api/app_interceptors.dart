import 'package:dio/dio.dart';
import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/config/di/injectable_config.dart';
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
    // await fss.write(key: Apikeys.accessToken, value: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkcml2ZXIiOiI2YTNiZTk2NTk5MjYxMmFlNTk5YjNkODQiLCJpYXQiOjE3ODIzNTY1MTF9.q9GnRjksBUOkyANhtnF5kSIizHAmpnG805ya7h8brn0");
    // String? authToken = await fss.read(key: Apikeys.accessToken);
    String? authToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkcml2ZXIiOiI2YTNiZTk2NTk5MjYxMmFlNTk5YjNkODQiLCJpYXQiOjE3ODM2ODc2NzV9.O8x7U0oZ4l45oYsbvlgSJVROR9WhEZsyKBEWSef1kpU';
    if (authToken != null && authToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $authToken';
      options.headers[Apikeys.token] = authToken;
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // ToDo
    super.onResponse(response, handler);
  }
}
