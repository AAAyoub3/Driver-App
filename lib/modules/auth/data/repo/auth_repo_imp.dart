import 'package:flowery/modules/auth/data/data_sources/auth_remote_data_source_contract.dart';
import 'package:flowery/modules/auth/domain/repo/auth_repo_contract.dart';
import 'package:injectable/injectable.dart';


@Injectable(as: AuthRepoContract)
class AuthRepoImp implements AuthRepoContract{
  final AuthRemoteDataSourceContract remoteDataSource;
  AuthRepoImp(this.remoteDataSource);
}