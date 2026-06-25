import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/profile/domain/entities/change_password_entity.dart';
import 'package:flowery/modules/profile/domain/repo/profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordUseCase {
  final ProfileRepoContract repo;
  ChangePasswordUseCase(this.repo);

  Future<Result<ChangePasswordEntity>> call(
    String password,
    String newPassword,
  ) => repo.changePassword(password, newPassword);
}
