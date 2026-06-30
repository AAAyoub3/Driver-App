import 'package:flowery/modules/profile/api/api_client/profile_api_client.dart';
import 'package:flowery/modules/profile/data/data_sources/profile_remote_data_sources_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDataSourcesContract)
class ProfileRemoteDataSourcesImpl implements ProfileRemoteDataSourcesContract {
  final ProfileApiClient apiClient;
  ProfileRemoteDataSourcesImpl(this.apiClient);
}
