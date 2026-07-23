import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/auth/api/api_client/auth_api_client.dart';
import 'package:flowery/modules/auth/data/data_sources/auth_remote_data_source_contract.dart';

import 'package:injectable/injectable.dart';

import '../../../../config/handler/dio_exception_handler.dart';
import '../../data/models/request/login_request_model.dart';
import '../../data/models/response/login_response_model.dart';
const bool isMock = true;
@Injectable(as: AuthRemoteDataSourceContract)
class AuthRemoteDataSourceImp implements AuthRemoteDataSourceContract {
  final AuthApiClient apiClient;
  AuthRemoteDataSourceImp(this.apiClient);

  @override
  Future<Result<LoginResponse>> login(
      LoginRequestModel request,
      ) async {
    try {
      final response = await apiClient.login(request);

      return Success(data: response);
    } on DioException catch (e) {
      return Error(
        exception: await DioExceptionHandler.handle(e),
      );
    } on Exception catch (e) {
      return Error(exception: e);
    }
  }


}
