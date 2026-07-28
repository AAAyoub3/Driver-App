import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/auth/data/data_sources/vehicles_remote_data_source_contract.dart';
import 'package:flowery/modules/auth/data/models/responses/vehicle_model.dart';
import 'package:flowery/modules/auth/domain/entities/vehicle_entity.dart';
import 'package:flowery/modules/auth/domain/repo/vehicles_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: VehiclesRepoContract)
class VehiclesRepoImp implements VehiclesRepoContract {
  final VehiclesRemoteDataSourceContract vehiclesRemoteDataSourceContract;
  VehiclesRepoImp(this.vehiclesRemoteDataSourceContract);

  @override
  Future<Result<List<VehicleEntity>>> getVehicles() async {
    final response = await vehiclesRemoteDataSourceContract.getVehicles();
    switch (response) {
      case Success<List<Vehicle>>():
        return Success<List<VehicleEntity>>(
          data: response.data?.map((vehicle) => vehicle.toEntity()).toList(),
        );
      case Error<List<Vehicle>>():
        return Error<List<VehicleEntity>>(exception: response.exception);
    }
  }
}
