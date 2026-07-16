import 'dart:io';

import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/profile/data/models/responses/change_password_response.dart';
import 'package:flowery/modules/profile/data/models/responses/edit_profile_response.dart';
import 'package:flowery/modules/profile/data/models/responses/upload_profile_photo_response.dart';
import 'package:flowery/modules/profile/domain/entities/upload_profile_photo_entity.dart';

abstract interface class ProfileRemoteDataSourcesContract {
  Future<Result<ChangePasswordResponse>> changePassword(
    String password,
    String newPassword,
  );
  Future<Result<EditProfileResponse>> editProfile(
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    // String gender,
  );
  Future<Result<UploadProfilePhotoResponse>> uploadProfilePhoto(File file);
}
