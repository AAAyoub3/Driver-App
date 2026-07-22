import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/auth/data/models/requestes/forget_password_request.dart';
import 'package:flowery/modules/auth/data/models/requestes/reset_password_request.dart';
import 'package:flowery/modules/auth/data/models/requestes/verify_reset_password_request.dart';
import 'package:flowery/modules/auth/data/models/responses/forget_password_response.dart';
import 'package:flowery/modules/auth/data/models/responses/reset_password_response.dart';
import 'package:flowery/modules/auth/data/models/responses/verify_email_response.dart';

abstract class AuthRemoteDataSourceContract {

  Future<Result<ForgetPasswordResponse>> forgetPassword(ForgetPasswordRequest request,);

  Future<Result<VerifyEmailResponse>> verifyEmail(VerifyResetPasswordRequest request);

  Future<Result<ResetPasswordResponse>> resetPassword(
      ResetPasswordRequest request,
      );
}