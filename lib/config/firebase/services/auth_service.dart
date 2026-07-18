import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/config/api/app_endpoints.dart';
import 'package:flowery/config/firebase/services/firestore_service.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthService {
  final FirestoreService _firestoreService;
  AuthService(this._firestoreService);

  Future<String> getAuthTokenForNotification() async {
    final credentials = await _firestoreService.getFirebaseAdminCredentials();

    final json = credentials.toJson();

    json[Apikeys.privateKey] = (json[Apikeys.privateKey] as String).replaceAll(
      r'\n',
      '\n',
    );

    final accountCredentials = ServiceAccountCredentials.fromJson(json);

    final client = await clientViaServiceAccount(accountCredentials, [
      AppEndPoints.firebaseMessagingScope,
    ]);

    return client.credentials.accessToken.data;
  }
}
