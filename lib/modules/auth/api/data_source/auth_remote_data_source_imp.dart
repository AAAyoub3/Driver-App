import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/handler/dio_exception_handler.dart';
import 'package:flowery/modules/auth/api/api_client/auth_api_client.dart';
import 'package:flowery/modules/auth/data/data_sources/auth_remote_data_source_contract.dart';
import 'package:flowery/modules/auth/data/models/apply_body.dart';
import 'package:flowery/modules/auth/data/models/apply_response.dart';
import 'package:flowery/modules/auth/domain/entities/apply_body_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSourceContract)
class AuthRemoteDataSourceImp implements AuthRemoteDataSourceContract {
  final AuthApiClient apiClient;
  AuthRemoteDataSourceImp(this.apiClient);

  @override
  Future<Result<ApplyResponse>> sendApplication(ApplyBodyEntity body) async {
    try {
      final applyBody = ApplyBody.fromEntity(body);
      final response = await apiClient.apply(
        firstName: applyBody.firstName,
        lastName: applyBody.lastName,
        email: applyBody.email,
        phone: applyBody.phone,
        password: applyBody.password,
        gender: applyBody.gender,
        rePassword: applyBody.repassword,
        country: applyBody.country,
        vehicleType: applyBody.vehicleType,
        vehicleNumber: applyBody.vehicleNumber,
        vehicleLicense: await applyBody.toLicenseFile(),
        nid: applyBody.nid,
        nidImg: await applyBody.toNidImgFile(),
      );
      return Success<ApplyResponse>(data: response);
    } on DioException catch (e) {
      return Error<ApplyResponse>(exception: DioExceptionHandler.handle(e));
    }
  }
}
