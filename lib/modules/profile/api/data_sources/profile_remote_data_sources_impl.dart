import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/handler/dio_exception_handler.dart';
import 'package:flowery/modules/profile/api/api_client/profile_api_client.dart';
import 'package:flowery/modules/profile/data/data_sources/profile_remote_data_sources_contract.dart';
import 'package:flowery/modules/profile/data/models/requests/change_password_request.dart';
import 'package:flowery/modules/profile/data/models/requests/edit_vieckle_request.dart';
import 'package:flowery/modules/profile/data/models/responses/change_password_response.dart';
import 'package:flowery/modules/profile/data/models/responses/edit_vieckle_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDataSourcesContract)
class ProfileRemoteDataSourcesImpl implements ProfileRemoteDataSourcesContract {
  final ProfileApiClient apiClient;
  ProfileRemoteDataSourcesImpl(this.apiClient);

  @override
  Future<Result<ChangePasswordResponse>> changePassword(
    String password,
    String newPassword,
  ) async {
    try {
      final response = await apiClient.changePassword(
        request: ChangePasswordRequest(
          password: password,
          newPassword: newPassword,
        ),
      );
      return Success<ChangePasswordResponse>(data: response);
    } on DioException catch (e) {
      return Error<ChangePasswordResponse>(
        exception: DioExceptionHandler.handle(e),
      );
    }
  }

  @override
  Future<EditVieckleResponse> editVickleInfo({
    required EditVehicleRequest request,
  }) async {
    // Simulate network latency
    await Future.delayed(const Duration(milliseconds: 800));

    // Uncomment when the real endpoint is ready:
    // return apiClient.editVickleInfo(request: request);

    // ---- FAKE DATA (success case) ----
    return EditVieckleResponse(
      message: 'Vehicle info updated successfully',
      error: null,
    );

    // ---- FAKE DATA (error case) — swap in to test failure UI ----
    // return EditVieckleResponse(
    //   message: null,
    //   error: 'Vehicle plate number already exists',
  }
}
