import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/auth/data/data_sources/auth_remote_data_source_contract.dart';
import 'package:flowery/modules/auth/data/models/requests/apply_request.dart';
import 'package:flowery/modules/auth/data/models/responses/apply_response.dart';
import 'package:flowery/modules/auth/data/models/responses/country_model.dart';
import 'package:flowery/modules/auth/domain/entities/apply_response_entity.dart';
import 'package:flowery/modules/auth/domain/entities/country_entity.dart';
import 'package:flowery/modules/auth/domain/repo/auth_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepoContract)
class AuthRepoImp implements AuthRepoContract {
  final AuthRemoteDataSourceContract authRemoteDataSourceContract;
  AuthRepoImp(
    this.authRemoteDataSourceContract,
  );

  @override
  Future<Result<ApplyResponseEntity>> sendApplication(ApplyRequest request) async {
    final response = await authRemoteDataSourceContract.sendApplication(request);
    switch (response) {
      case Success<ApplyResponse>():
        return Success<ApplyResponseEntity>(data: response.data?.toEntity());
      case Error<ApplyResponse>():
        return Error<ApplyResponseEntity>(exception: response.exception);
    }
  }

  @override
  Future<Result<List<CountryEntity>>> getCountries() async {
    final response = await authRemoteDataSourceContract.getCountries();
    switch (response) {
      case Success<List<CountryModel>>():
        return Success<List<CountryEntity>>(
          data: response.data?.map((country) => country.toEntity()).toList(),
        );
      case Error<List<CountryModel>>():
        return Error<List<CountryEntity>>(exception: response.exception);
    }
  }
}
