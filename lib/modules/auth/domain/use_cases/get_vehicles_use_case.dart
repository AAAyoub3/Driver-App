import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/auth/domain/entities/vehicle_entity.dart';
import 'package:flowery/modules/auth/domain/repo/vehicles_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetVehiclesUseCase {
  final VehiclesRepoContract contract;
  GetVehiclesUseCase(this.contract);

  Future<Result<List<VehicleEntity>>> call() {
    return contract.getVehicles();
  }
}
