import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/auth/domain/entities/apply_body_entity.dart';
import 'package:flowery/modules/auth/domain/entities/apply_response_entity.dart';
import 'package:flowery/modules/auth/domain/entities/country_entity.dart';

abstract class AuthRepoContract {
  Future<Result<ApplyResponseEntity>> sendApplication(ApplyBodyEntity body);
  Future<Result<List<CountryEntity>>> getCountries();
}
