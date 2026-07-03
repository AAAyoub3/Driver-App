import 'package:flowery/config/firebase/services/firestore_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirebaseServices {
  final FirestoreService firestore;

  FirebaseServices(this.firestore);
}