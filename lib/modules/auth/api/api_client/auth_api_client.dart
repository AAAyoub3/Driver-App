import 'package:dio/dio.dart';
import 'package:flowery/config/api/app_endpoints.dart';
import 'package:flowery/modules/auth/data/models/apply_response.dart';
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
    @Part(name: 'firstName') required String firstName,
    @Part(name: 'lastName') required String lastName,
    @Part(name: 'email') required String email,
    @Part(name: 'phone') required String phone,
    @Part(name: 'password') required String password,
    @Part(name: 'gender') required String gender,
    @Part(name: 'country') required String country,
    @Part(name: 'vehicleType') required String vehicleType,
    @Part(name: 'vehicleNumber') required String vehicleNumber,
    @Part(name: 'vehicleLicense') required MultipartFile vehicleLicense,
    @Part(name: 'NID') required String nid,
    @Part(name: 'NIDImg') required MultipartFile nidImg,
    @Part(name: 'rePassword') required String rePassword,
  });
}
