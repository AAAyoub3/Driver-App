import 'package:dio/dio.dart';
import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/config/api/app_endpoints.dart';
import 'package:flowery/modules/auth/data/models/responses/apply_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'auth_api_client.g.dart';

@LazySingleton()
@RestApi()
abstract class AuthApiClient {
  @factoryMethod
  factory AuthApiClient(Dio dio) = _AuthApiClient;

  @POST(AppEndPoints.apply)
  @MultiPart()
  Future<ApplyResponse> apply({
    @Part(name: Apikeys.firstName) required String firstName,
    @Part(name: Apikeys.lastName) required String lastName,
    @Part(name: Apikeys.email) required String email,
    @Part(name: Apikeys.phone) required String phone,
    @Part(name: Apikeys.password) required String password,
    @Part(name: Apikeys.repassword) required String repassword,
    @Part(name: Apikeys.gender) required String gender,
    @Part(name: Apikeys.country) required String country,
    @Part(name: Apikeys.vehicleType) required String vehicleType,
    @Part(name: Apikeys.vehicleNumber) required String vehicleNumber,
    @Part(name: Apikeys.nid) required String nid,
    @Part(name: Apikeys.vehicleLicense) required MultipartFile vehicleLicense,
    @Part(name: Apikeys.nidImg) required MultipartFile nidImg,
  });
}
