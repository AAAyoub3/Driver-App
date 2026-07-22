import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/profile/data/models/responses/change_password_response.dart';
import 'package:flowery/modules/profile/data/models/responses/my_profile_response.dart';

abstract interface class ProfileRemoteDataSourcesContract {
  Future<Result<ChangePasswordResponse>> changePassword(
    String password,
    String newPassword,
  );
  Future<Result<MyProfileResponse>> getMyProfileData();
}
