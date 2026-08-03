

import '../../../../config/base_response/base_response.dart';
import '../models/request/login_request_model.dart';
import '../models/response/login_response_model.dart';

abstract interface class AuthRemoteDataSourceContract {
  Future<Result<LoginResponse>> login(LoginRequestModel request);


}