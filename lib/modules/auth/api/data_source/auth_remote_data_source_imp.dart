import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/handler/dio_exception_handler.dart';
import 'package:flowery/modules/auth/api/clients/api_client/auth_api_client.dart';
import 'package:flowery/modules/auth/api/clients/local_client/countries_local_client.dart';
import 'package:flowery/modules/auth/data/data_sources/auth_remote_data_source_contract.dart';
import 'package:flowery/modules/auth/data/models/requests/apply_request.dart';
import 'package:flowery/modules/auth/data/models/responses/apply_response.dart';
import 'package:flowery/modules/auth/data/models/responses/country_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSourceContract)
class AuthRemoteDataSourceImp implements AuthRemoteDataSourceContract {
  final AuthApiClient apiClient;
  final CountriesLocalClient countriesLocalClient;
  AuthRemoteDataSourceImp(this.apiClient, this.countriesLocalClient);

  @override
  Future<Result<ApplyResponse>> sendApplication(ApplyRequest request) async {
    try {
      final response = await apiClient.apply(
        firstName: request.firstName,
        lastName: request.lastName,
        email: request.email,
        phone: request.phone,
        password: request.password,
        repassword: request.repassword,
        gender: request.gender,
        country: request.country,
        vehicleType: request.vehicleType,
        vehicleNumber: request.vehicleNumber,
        nid: request.nid,
        vehicleLicense: await request.toMultiFile(request.vehicleLicense),
        nidImg: await request.toMultiFile(request.nidImg),
      );
      return Success<ApplyResponse>(data: response);
    } on DioException catch (e) {
      return Error<ApplyResponse>(exception: DioExceptionHandler.handle(e));
    }
  }

  @override
  Future<Result<List<CountryModel>>> getCountries() async {
    try {
      final countries = await countriesLocalClient.getCountries();
      return Success<List<CountryModel>>(data: countries);
    } catch (e) {
      return Error<List<CountryModel>>(exception: Exception(e.toString()));
    }
  }
}
