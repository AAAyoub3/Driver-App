import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/auth/data/data_sources/auth_remote_data_source_contract.dart';
import 'package:flowery/modules/auth/data/models/requestes/forget_password_request.dart';
import 'package:flowery/modules/auth/data/models/requestes/reset_password_request.dart';
import 'package:flowery/modules/auth/data/models/requestes/verify_reset_password_request.dart';
import 'package:flowery/modules/auth/data/models/responses/forget_password_response.dart';
import 'package:flowery/modules/auth/data/models/responses/reset_password_response.dart';
import 'package:flowery/modules/auth/data/models/responses/verify_email_response.dart';
import 'package:flowery/modules/auth/domain/repo/auth_repo_contract.dart';
import 'package:injectable/injectable.dart';


@Injectable(as: AuthRepoContract)
class AuthRepoImp implements AuthRepoContract{
  final AuthRemoteDataSourceContract remoteDataSource;
  AuthRepoImp(this.remoteDataSource);

   @override
  Future<Result<ForgetPasswordResponse>> forgetPassword(
      ForgetPasswordRequest request,
      ) {
    return remoteDataSource.forgetPassword(request);
  }

  @override
  Future<Result<VerifyEmailResponse>> verifyEmail(VerifyResetPasswordRequest request) async {
    return await remoteDataSource.verifyEmail(request);

  }


  @override
  Future<Result<ResetPasswordResponse>> resetPassword(
      ResetPasswordRequest request,
      ) async {
    return  await remoteDataSource.resetPassword(request);

  }

}