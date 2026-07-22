import 'package:dio/dio.dart';
import 'package:flowery/config/api/app_endpoints.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/profile/data/models/requests/change_password_request.dart';
import 'package:flowery/modules/profile/data/models/requests/edit_profile_request.dart';
import 'package:flowery/modules/profile/data/models/requests/upload_profile_photo_request.dart';
import 'package:flowery/modules/profile/data/models/responses/change_password_response.dart';
import 'package:flowery/modules/profile/data/models/responses/edit_profile_response.dart';
import 'package:flowery/modules/profile/data/models/responses/upload_profile_photo_response.dart';
import 'package:flowery/modules/profile/data/models/responses/my_profile_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'profile_api_client.g.dart';

@LazySingleton()
@RestApi()
abstract class ProfileApiClient {
  @factoryMethod
  factory ProfileApiClient(Dio dio) = _ProfileApiClient;

  @PATCH(AppEndPoints.changePassword)
  Future<ChangePasswordResponse> changePassword({
    @Body() required ChangePasswordRequest request,
  });

  @PUT(AppEndPoints.editProfile)
  Future<EditProfileResponse> editProfile({
    @Body() required EditProfileRequest request,
  });

  @PUT(AppEndPoints.uploadProfilePhoto)
  Future<UploadProfilePhotoResponse> uploadProfilePhoto({
    @Body() required UploadProfilePhotoRequest request,
  });
  @GET(AppEndPoints.my_profile)
  Future<MyProfileResponse> getMyProfileData();

  
}
