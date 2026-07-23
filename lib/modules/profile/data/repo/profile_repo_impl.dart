import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/profile/data/data_sources/profile_local_data_sources_contract.dart';
import 'package:flowery/modules/profile/data/data_sources/profile_remote_data_sources_contract.dart';
import 'package:flowery/modules/profile/data/models/requests/edit_vieckle_request.dart';
import 'package:flowery/modules/profile/data/models/responses/change_password_response.dart';
import 'package:flowery/modules/profile/data/models/responses/edit_vieckle_response.dart';
import 'package:flowery/modules/profile/domain/entities/change_password_entity.dart';
import 'package:flowery/modules/profile/domain/repo/profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepoContract)
class ProfileRepoImpl implements ProfileRepoContract {
  final ProfileRemoteDataSourcesContract remoteDS;
  final ProfileLocalDataSourcesContract localDS;
  ProfileRepoImpl(this.remoteDS, this.localDS);

  @override
  Future<Result<ChangePasswordEntity>> changePassword(
    String password,
    String newPassword,
  ) async {
    final oldToken = await localDS.getUserTokenFromFSS();
    final response = await remoteDS.changePassword(password, newPassword);
    switch (response) {
      case Success<ChangePasswordResponse>():
        await localDS.updateUserTokenFromFSS(response.data?.token ?? "");
        return Success<ChangePasswordEntity>(data: response.data?.toEntity());
      case Error<ChangePasswordResponse>():
        await localDS.updateUserTokenFromFSS(oldToken ?? "");
        return Error<ChangePasswordEntity>(exception: response.exception);
    }
  }

  @override
  Future<Result<EditVieckleResponse>> editVickleInfo({
    required EditVehicleRequest request,
  }) async {
    try {
      final response = await remoteDS.editVickleInfo(request: request);

      if (response.error != null) {
        return Error(exception: Exception(response.error));
      }

      return Success(data: response);
    } on DioException catch (e) {
      return Error(exception: Exception(e.message ?? 'Something went wrong'));
    } catch (e) {
      return Error(exception: Exception(e.toString()));
    }
  }
}
