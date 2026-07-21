import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/auth/api/local_client/local_client.dart';
import 'package:flowery/modules/auth/data/data_sources/countries_local_data_source_contract.dart';
import 'package:flowery/modules/auth/data/models/country_model.dart';

class CountriesLocalDataSourceImp implements CountriesLocalDataSourceContract {
  final LocalClient localClient;
  CountriesLocalDataSourceImp(this.localClient);

  @override
  Future<Result<List<CountryModel>>> getCountries() async {
    try {
      final countries = await localClient.getCountries();
      return Success<List<CountryModel>>(data: countries);
    } catch (e) {
      return Error<List<CountryModel>>(exception: Exception(e.toString()));
    }
  }
}
