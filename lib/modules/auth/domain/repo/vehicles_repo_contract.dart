import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/auth/domain/entities/vehicle_entity.dart';

abstract interface class VehiclesRepoContract {
  Future<Result<List<VehicleEntity>>> getVehicles();
}
