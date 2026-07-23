import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/auth/data/models/responses/vehicle_model.dart';

abstract interface class VehiclesRemoteDataSourceContract {
  Future<Result<List<Vehicle>>> getVehicles();
}
