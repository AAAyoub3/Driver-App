import 'package:dio/dio.dart';
import 'package:flowery/config/api/app_endpoints.dart';
import 'package:flowery/modules/auth/data/models/responses/vehicles_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'vehicles_api_client.g.dart';

@LazySingleton()
@RestApi()
abstract class VehiclesApiClient {
  @factoryMethod
  factory VehiclesApiClient(Dio dio) = _VehiclesApiClient;

  @GET(AppEndPoints.vehicles)
  Future<VehiclesResponse> getVehicles();
}
