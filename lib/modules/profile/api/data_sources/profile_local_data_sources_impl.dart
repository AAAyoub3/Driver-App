import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/modules/profile/data/data_sources/profile_local_data_sources_contract.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileLocalDataSourcesContract)
class ProfileLocalDataSourcesImpl
    implements ProfileLocalDataSourcesContract {
  final FlutterSecureStorage fss;
  ProfileLocalDataSourcesImpl(this.fss);

  @override
  Future<String?> getUserTokenFromFSS() async {
    return await fss.read(key: Apikeys.accessToken);
  }

  @override
  Future<void> updateUserTokenFromFSS(String token) async {
    await fss.write(key: Apikeys.accessToken, value: token);
  }
}
