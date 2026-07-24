import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/handler/dio_exception_handler.dart';
import 'package:flowery/modules/auth/api/clients/api_client/vehicles_api_client.dart';
import 'package:flowery/modules/auth/data/data_sources/vehicles_remote_data_source_contract.dart';
import 'package:flowery/modules/auth/data/models/responses/vehicle_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: VehiclesRemoteDataSourceContract)
class VehiclesRemoteDataSourceImp implements VehiclesRemoteDataSourceContract {
  final VehiclesApiClient vehiclesApiClient;
  VehiclesRemoteDataSourceImp(this.vehiclesApiClient);

  @override
  Future<Result<List<Vehicle>>> getVehicles() async {
    try {
      final response = await vehiclesApiClient.getVehicles();
      return Success<List<Vehicle>>(data: response.vehicles);
    } on DioException catch (e) {
      return Error<List<Vehicle>>(exception: DioExceptionHandler.handle(e));
    }
  }
}
