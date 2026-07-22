import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/auth/api/api_client/auth_api_client.dart';
import 'package:flowery/modules/auth/data/data_sources/auth_remote_data_source_contract.dart';

import 'package:injectable/injectable.dart';
const bool isMock = true;
@Injectable(as: AuthRemoteDataSourceContract)
class AuthRemoteDataSourceImp implements AuthRemoteDataSourceContract {
  final AuthApiClient apiClient;
  AuthRemoteDataSourceImp(this.apiClient);




}
