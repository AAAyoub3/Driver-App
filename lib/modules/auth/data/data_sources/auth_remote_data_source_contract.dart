import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/auth/data/models/requests/apply_request.dart';
import 'package:flowery/modules/auth/data/models/responses/apply_response.dart';
import 'package:flowery/modules/auth/data/models/responses/country_model.dart';

abstract interface class AuthRemoteDataSourceContract {
  Future<Result<ApplyResponse>> sendApplication(ApplyRequest request);
  Future<Result<List<CountryModel>>> getCountries();
}
