import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/auth/data/models/requestes/forget_password_request.dart';
import 'package:flowery/modules/auth/data/models/responses/forget_password_response.dart';
import 'package:flowery/modules/auth/domain/repo/auth_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordUseCase {
  AuthRepoContract repo;

  ForgetPasswordUseCase(this.repo);

  Future<Result<ForgetPasswordResponse>> forgetPassword(
      ForgetPasswordRequest request,
      ) {
    return repo.forgetPassword(request);
  }
}

