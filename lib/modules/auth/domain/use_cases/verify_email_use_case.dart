import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/auth/data/models/requestes/verify_reset_password_request.dart';
import 'package:flowery/modules/auth/data/models/responses/verify_email_response.dart';
import 'package:flowery/modules/auth/domain/repo/auth_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerifyEmailUseCase {
  AuthRepoContract repo;

  VerifyEmailUseCase(this.repo);

  Future<Result<VerifyEmailResponse>> verifyEmail(
      VerifyResetPasswordRequest request,
      ) {
    return repo.verifyEmail(request);
  }
}