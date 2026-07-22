import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/auth/api/api_client/auth_api_client.dart';
import 'package:flowery/modules/auth/data/data_sources/auth_remote_data_source_contract.dart';
import 'package:flowery/modules/auth/data/models/requestes/forget_password_request.dart';
import 'package:flowery/modules/auth/data/models/requestes/reset_password_request.dart';
import 'package:flowery/modules/auth/data/models/requestes/verify_reset_password_request.dart';
import 'package:flowery/modules/auth/data/models/responses/forget_password_response.dart';
import 'package:flowery/modules/auth/data/models/responses/reset_password_response.dart';
import 'package:flowery/modules/auth/data/models/responses/verify_email_response.dart';
import 'package:injectable/injectable.dart';
const bool isMock = true;
@Injectable(as: AuthRemoteDataSourceContract)
class AuthRemoteDataSourceImp implements AuthRemoteDataSourceContract {
  final AuthApiClient apiClient;
  AuthRemoteDataSourceImp(this.apiClient);



  @override
  Future<Result<ForgetPasswordResponse>> forgetPassword(
    ForgetPasswordRequest request,
  ) async {
    if (isMock) {
      await Future.delayed(const Duration(seconds: 2));

      return Success(data: ForgetPasswordResponse());
    }
final response = await apiClient.forgetPassword(request);
  return Success(data: response);
  }

  @override
  Future<Result<VerifyEmailResponse>> verifyEmail(
    VerifyResetPasswordRequest request,
  ) async {
    // ================= MOCK =================
    if (isMock) {
      await Future.delayed(const Duration(seconds: 2));

      return Success(data: VerifyEmailResponse());
    }

    final response = await apiClient.verifyEmail(request);
  return Success(data: response);

  }

  @override
  Future<Result<ResetPasswordResponse>> resetPassword(
    ResetPasswordRequest request,
  ) async {
    // ================= MOCK =================
    if (isMock) {
      await Future.delayed(const Duration(seconds: 2));

      return Success(data: ResetPasswordResponse());
    }

final response = await apiClient.resetPassword(request);
  return Success(data: response);

  }
}
