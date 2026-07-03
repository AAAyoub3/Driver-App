import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class FcmService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  Future<void> sendNotificationToUser() async {
  }
}
