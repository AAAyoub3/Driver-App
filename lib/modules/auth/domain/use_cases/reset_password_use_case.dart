import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/auth/data/models/requestes/reset_password_request.dart';
import 'package:flowery/modules/auth/data/models/responses/reset_password_response.dart';
import 'package:flowery/modules/auth/domain/repo/auth_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordUseCase {
  AuthRepoContract repo;

  ResetPasswordUseCase(this.repo);

  Future<Result<ResetPasswordResponse>> resetPassword(
      ResetPasswordRequest request,
      ) {
    return repo.resetPassword(request);
  }
}