import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/profile/domain/entities/my_profile_entity.dart';
import 'package:flowery/modules/profile/domain/repo/profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMyProfileDataUseCase {
  ProfileRepoContract repo;
  GetMyProfileDataUseCase(this.repo);

  Future<Result<MyProfileEntity>> call() => repo.getMyProfileData();
}
