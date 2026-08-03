import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../data/models/request/login_request_model.dart';
import '../entity/login_entity.dart';
import '../repo_contract/login_repo_contract.dart';

@injectable
class LoginUseCase {
  final LoginRepoContract _loginRepo;

  LoginUseCase(this._loginRepo);

  Future<Result<LoginEntity>> call(
    LoginRequestModel request, {
    required bool rememberMe,
  }) {
    return _loginRepo.login(request, rememberMe: rememberMe);
  }
}
