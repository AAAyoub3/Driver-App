import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/modules/order_tracking/data/models/responses/auth_credentials.dart';
import 'package:flowery/modules/order_tracking/data/models/responses/driver_location.dart';
import 'package:flowery/modules/order_tracking/data/models/responses/order_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirestoreService {
  final FirebaseFirestore _firestore;
  final AppLocalizations _localizations;
  FirestoreService(this._firestore, this._localizations);

  Future<OrderModel> getOrderFromFirestore({required String driverId}) async {
    final snapshot = await _firestore
        .collection(Apikeys.acceptedOrders)
        .where(Apikeys.driverId, isEqualTo: driverId)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      throw Exception(_localizations.no_accepted_order_found_for_this_driver);
    }

    return OrderModel.fromJson(snapshot.docs.first.data());
  }

  Future<String?> getUserFcmToken(String userId) async {
    final snapshot = await _firestore
        .collection(Apikeys.users)
        .doc(userId)
        .get();

    return snapshot.get(Apikeys.fcmToken);
  }

  Future<String?> getUserLanguage(String userId) async {
    final snapshot = await _firestore
        .collection(Apikeys.users)
        .doc(userId)
        .get();

    return snapshot.get(Apikeys.language);
  }

  Future<OrderModel> updateOrderStateInFirestore({
    required String orderId,
    required String status,
  }) async {
    final docRef = _firestore.collection(Apikeys.acceptedOrders).doc(orderId);

    await docRef.update({Apikeys.status: status});

    final updatedDoc = await docRef.get();

    if (!updatedDoc.exists) {
      throw Exception(_localizations.order_not_found);
    }

    return OrderModel.fromJson(updatedDoc.data() as Map<String, dynamic>);
  }

  Future<AuthCredentials> getFirebaseAdminCredentials() async {
    final credentialsRef = _firestore
        .collection(Apikeys.secrets)
        .withConverter<AuthCredentials>(
          fromFirestore: (snapshot, _) =>
              AuthCredentials.fromJson(snapshot.data()!),
          toFirestore: (credentials, _) => credentials.toJson(),
        );

    final snapshot = await credentialsRef.doc(Apikeys.firebaseAdmin).get();

    if (!snapshot.exists) {
      throw Exception(_localizations.firebase_admin_credentials_not_found);
    }

    return snapshot.data()!;
  }

  Future<DriverLocation> getDriverLocation(String driverId) async {
    final snapshot = await _firestore
        .collection(Apikeys.driverLocations)
        .doc(driverId)
        .get();

    if (!snapshot.exists) {
      throw Exception();
    }

    return DriverLocation.fromJson(snapshot.data()!);
  }

  Future<void> updateDriverLocation({
    required String driverId,
    required double latitude,
    required double longitude,
    required double accuracy,
  }) async {
    await _firestore.collection(Apikeys.driverLocations).doc(driverId).set({
      Apikeys.latitude: latitude,
      Apikeys.longitude: longitude,
      Apikeys.accuracy: accuracy,
      Apikeys.updatedAt: DateTime.now().toIso8601String(),
    }, SetOptions(merge: true));
  }
}
