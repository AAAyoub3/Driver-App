import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../config/api/app_endpoints.dart';
import '../../data/models/request/login_request_model.dart';
import '../../data/models/response/login_response_model.dart';

part 'auth_api_client.g.dart';

@LazySingleton()
@RestApi()
abstract class AuthApiClient {
  @factoryMethod
  factory AuthApiClient(Dio dio) = _AuthApiClient;

  @POST(AppEndPoints.signin)
  Future<LoginResponse> login(@Body() LoginRequestModel requests);
}
