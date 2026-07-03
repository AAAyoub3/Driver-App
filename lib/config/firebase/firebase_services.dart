import 'package:flowery/config/firebase/services/fcm_service.dart';
import 'package:flowery/config/firebase/services/firestore_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirebaseServices {
  final FirestoreService firestore;
  final FcmService fcm;

  FirebaseServices(this.firestore, this.fcm);
}