import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/auth/data/models/country_model.dart';

abstract interface class CountriesLocalDataSourceContract {
  Future<Result<List<CountryModel>>> getCountries();
}
