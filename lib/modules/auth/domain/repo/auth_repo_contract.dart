import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/auth/data/models/requests/apply_request.dart';
import 'package:flowery/modules/auth/domain/entities/apply_response_entity.dart';
import 'package:flowery/modules/auth/domain/entities/country_entity.dart';

abstract interface class AuthRepoContract {
  Future<Result<ApplyResponseEntity>> sendApplication(ApplyRequest request);
  Future<Result<List<CountryEntity>>> getCountries();
}
