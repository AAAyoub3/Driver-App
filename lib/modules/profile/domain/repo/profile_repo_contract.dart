import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/profile/data/models/requests/edit_vieckle_request.dart';
import 'package:flowery/modules/profile/data/models/responses/edit_vieckle_response.dart';
import 'package:flowery/modules/profile/domain/entities/change_password_entity.dart';

abstract interface class ProfileRepoContract {
  Future<Result<ChangePasswordEntity>> changePassword(
    String password,
    String newPassword,
  );
   Future<Result<EditVieckleResponse>> editVickleInfo({
    required EditVehicleRequest request,
  });
}
