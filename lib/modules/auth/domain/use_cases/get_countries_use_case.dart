import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/auth/domain/entities/country_entity.dart';
import 'package:flowery/modules/auth/domain/repo/auth_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCountriesUseCase {
  final AuthRepoContract contract;
  GetCountriesUseCase(this.contract);

  Future<Result<List<CountryEntity>>> call() {
    return contract.getCountries();
  }
}
