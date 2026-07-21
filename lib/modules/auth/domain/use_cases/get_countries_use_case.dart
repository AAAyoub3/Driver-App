import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/auth/domain/entities/country_entity.dart';
import 'package:flowery/modules/auth/domain/repo/auth_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCountriesUseCase {
  final AuthRepoContract repository;
  GetCountriesUseCase(this.repository);

  Future<Result<List<CountryEntity>>> getCountries() {
    return repository.getCountries();
  }
}
