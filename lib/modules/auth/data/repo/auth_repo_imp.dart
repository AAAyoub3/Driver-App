

import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../domain/entity/login_entity.dart';
import '../../domain/repo_contract/login_repo_contract.dart';
import '../data_sources/auth_remote_data_source_contract.dart';
import '../models/request/login_request_model.dart';
import '../models/response/login_response_model.dart';

@Injectable(as: LoginRepoContract)
class LoginRepoImpl implements LoginRepoContract {
  final AuthRemoteDataSourceContract _remoteDataSource;

  LoginRepoImpl(this._remoteDataSource);

  @override
  Future<Result<LoginEntity>> login(
      LoginRequestModel request,
      ) async {
    final result = await _remoteDataSource.login(request);

    switch (result) {
      case Success<LoginResponse>():
        return Success(
          data: result.data?.toDomain(),
        );

      case Error<LoginResponse>():
        return Error(
          exception: result.exception,
        );
    }
  }
}