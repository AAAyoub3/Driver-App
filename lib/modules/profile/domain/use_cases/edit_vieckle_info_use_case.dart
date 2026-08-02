import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/profile/data/models/requests/edit_vieckle_request.dart';
import 'package:flowery/modules/profile/data/models/responses/edit_vieckle_response.dart';
import 'package:flowery/modules/profile/domain/repo/profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditVehicleUseCase {
  final ProfileRepoContract repo;

  EditVehicleUseCase(this.repo);

  Future<Result<EditVieckleResponse>> call({
    required EditVehicleRequest request,
  }) {
    return repo.editVickleInfo(request: request);
  }
}