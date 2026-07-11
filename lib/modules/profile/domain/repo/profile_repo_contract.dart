import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/profile/domain/entities/change_password_entity.dart';
import 'package:flowery/modules/profile/domain/entities/my_profile_entity.dart';

abstract interface class ProfileRepoContract {
  Future<Result<ChangePasswordEntity>> changePassword(
    String password,
    String newPassword,
  );
  Future<Result<MyProfileEntity>> getMyProfileData();
}
