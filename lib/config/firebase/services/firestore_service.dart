import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/config/api/app_endpoints.dart';
import 'package:flowery/modules/order_tracking/data/models/responses/order_model.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirestoreService {
  final FirebaseFirestore _firestore;
  FirestoreService(this._firestore);


  Future<OrderModel> getOrderFromFirestore({required String driverId}) async {
    final snapshot = await _firestore
        .collection('accepted_orders')
        .where('driverId', isEqualTo: driverId)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      throw Exception('No accepted order found for this driver');
    }

    return OrderModel.fromJson(snapshot.docs.first.data());
  }

  Future<String?> getUserFcmToken(String userId) async {
    // Getting user fcm token
    final snapshot = await _firestore.collection('users').doc(userId).get();
    return snapshot.get("fcmToken");
  }

  Future<OrderModel> updateOrderStateInFirestore({
    required String orderId,
    required String status,
  }) async {
    final docRef = _firestore.collection('accepted_orders').doc(orderId);
    await docRef.update({'status': status});
    final updatedDoc = await docRef.get();
    if (!updatedDoc.exists) {
      throw Exception('Order not found');
    }

    return OrderModel.fromJson(updatedDoc.data() as Map<String, dynamic>);
  }

    Future<String> getAuthTokenForNotification() async {
    final jsonMap = await getFirebaseAdminCredentials();
    jsonMap[Apikeys.privateKey] = (jsonMap[Apikeys.privateKey] as String)
        .replaceAll(r'\n', '\n');
    final accountCredentials = ServiceAccountCredentials.fromJson(jsonMap);
    final client = await clientViaServiceAccount(accountCredentials, [
      AppEndPoints.firebaseMessagingScope,
    ]);

    return client.credentials.accessToken.data;
  }

  Future<Map<String, dynamic>> getFirebaseAdminCredentials() async {
    final snapshot = await _firestore
        .collection("secrets")
        .doc("firebase_admin")
        .get();

    if (!snapshot.exists) {
      throw Exception("Firebase admin credentials not found.");
    }

    return snapshot.data()!;
  }
}
