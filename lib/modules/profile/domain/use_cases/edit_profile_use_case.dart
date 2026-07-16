import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/profile/domain/entities/edit_profile_photo_entity.dart';
import 'package:flowery/modules/profile/domain/repo/profile_repo_contract.dart';
import 'package:injectable/injectable.dart';
@injectable
class EditProfileUseCase {
  final ProfileRepoContract repo;
  EditProfileUseCase(this.repo);

  Future<Result<EditProfileEntity>> call(
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    // String gender,
  ) => repo.editProfile(firstName, lastName, email, phoneNumber);
}
