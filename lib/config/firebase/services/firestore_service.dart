import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowery/modules/order_tracking/data/models/order_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<OrderModel> getOrderFromFirestore({required String driverId}) async {
    try {
      final snapshot = await _firestore
          .collection('accepted_orders')
          .where('driverId', isEqualTo: driverId)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        throw Exception('No accepted order found for this driver');
      }

      return OrderModel.fromJson(snapshot.docs.first.data());
    } on FirebaseException catch (e) {
      throw Exception('Failed to fetch order: ${e.message}');
    }
  }

  Future<String?> getUserFcmToken(String userId) async {
    try {
      // Getting user fcm token
      final snapshot = await _firestore.collection('users').doc(userId).get();
      return snapshot.get("fcmToken");
    } on FirebaseException catch (e) {
      throw Exception('Failed to fetch user fcm token: ${e.message}');
    }
  }

  Future<OrderModel> updateOrderStateInFirestore({
    required String orderId,
    required String status,
  }) async {
    try {
      final docRef = _firestore.collection('accepted_orders').doc(orderId);

      await docRef.update({'status': status});

      final updatedDoc = await docRef.get();

      if (!updatedDoc.exists) {
        throw Exception('Order not found');
      }

      return OrderModel.fromJson(updatedDoc.data() as Map<String, dynamic>);
    } on FirebaseException catch (e) {
      throw Exception('Failed to update order status: ${e.message}');
    }
  }
}
