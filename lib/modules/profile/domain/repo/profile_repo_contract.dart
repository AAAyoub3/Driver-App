import 'dart:io';

import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/profile/data/models/requests/edit_vieckle_request.dart';
import 'package:flowery/modules/profile/data/models/responses/edit_vieckle_response.dart';
import 'package:flowery/modules/profile/domain/entities/change_password_entity.dart';
import 'package:flowery/modules/profile/domain/entities/edit_profile_photo_entity.dart';
import 'package:flowery/modules/profile/domain/entities/upload_profile_photo_entity.dart';
import 'package:flowery/modules/profile/domain/entities/my_profile_entity.dart';

abstract interface class ProfileRepoContract {
  Future<Result<ChangePasswordEntity>> changePassword(
    String password,
    String newPassword,
  );
   Future<Result<EditVieckleResponse>> editVickleInfo({
    required EditVehicleRequest request,
  });

  Future<Result<EditProfileEntity>> editProfile(
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    // String gender,
  );

  Future<Result<UploadProfilePhotoEntity>> uploadProfilePhoto(File file);
  Future<Result<MyProfileEntity>> getMyProfileData();
}
