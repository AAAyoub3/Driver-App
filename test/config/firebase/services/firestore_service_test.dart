import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flowery/config/firebase/services/firestore_service.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  late FakeFirebaseFirestore firestore;
  late FirestoreService service;

  setUp(() {
    firestore = FakeFirebaseFirestore();
    service = FirestoreService(firestore);
  });

  group('getOrderFromFirestore', () {
    test('returns order', () async {
      await firestore.collection('accepted_orders').doc('1').set({
        'driverId': 'driver1',
        'acceptedAt': '',
        'email': '',
        'firstName': '',
        'lastName': '',
        'orderId': '1',
        'orderNumber': '',
        'phone': '',
        'photo': '',
        'status': '',
        'storeAddress': '',
        'storeImage': '',
        'storeName': '',
        'totalPrice': 10,
        'userAddress': '',
        'userName': '',
        'userPhoto': '',
        'userId': '',
        'vehicleNumber': '',
        'paymentMethod': '',
        'items': [],
      });

      final result =
          await service.getOrderFromFirestore(driverId: 'driver1');

      expect(result.driverId, 'driver1');
    });

    test('throws if no order exists', () {
      expect(
        () => service.getOrderFromFirestore(driverId: 'x'),
        throwsException,
      );
    });
  });

  group('getUserFcmToken', () {
    test('returns token', () async {
      await firestore.collection('users').doc('1').set({
        'fcmToken': 'abc123',
      });

      final token = await service.getUserFcmToken('1');

      expect(token, 'abc123');
    });
  });

  group('updateOrderStateInFirestore', () {
    test('updates status', () async {
      await firestore.collection('accepted_orders').doc('1').set({
        'driverId': 'driver',
        'acceptedAt': '',
        'email': '',
        'firstName': '',
        'lastName': '',
        'orderId': '1',
        'orderNumber': '',
        'phone': '',
        'photo': '',
        'status': 'Pending',
        'storeAddress': '',
        'storeImage': '',
        'storeName': '',
        'totalPrice': 10,
        'userAddress': '',
        'userName': '',
        'userPhoto': '',
        'userId': '',
        'vehicleNumber': '',
        'paymentMethod': '',
        'items': [],
      });

      final order = await service.updateOrderStateInFirestore(
        orderId: '1',
        status: 'Picked',
      );

      expect(order.status, 'Picked');
    });
  });

  group('getFirebaseAdminCredentials', () {
    test('returns credentials', () async {
      await firestore.collection('secrets').doc('firebase_admin').set({
        'type': 'service_account',
        'project_id': 'flowery',
      });

      final credentials =
          await service.getFirebaseAdminCredentials();

      expect(credentials['type'], 'service_account');
    });

    test('throws when credentials do not exist', () {
      expect(
        () => service.getFirebaseAdminCredentials(),
        throwsException,
      );
    });
  });
}