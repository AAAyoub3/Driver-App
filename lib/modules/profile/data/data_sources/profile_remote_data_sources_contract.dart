import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/profile/data/models/requests/edit_vieckle_request.dart';
import 'package:flowery/modules/profile/data/models/responses/change_password_response.dart';
import 'package:flowery/modules/profile/data/models/responses/edit_vieckle_response.dart';

abstract interface class ProfileRemoteDataSourcesContract {
  Future<Result<ChangePasswordResponse>> changePassword(String password, String newPassword);
    Future<EditVieckleResponse> editVickleInfo({
    required EditVehicleRequest request,
  });
}
