import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowery/modules/order_tracking/data/model/driver_profile_response_model.dart';
import 'package:flowery/modules/order_tracking/domain/entity/home_entity/order_entity.dart';
import 'package:injectable/injectable.dart';

@singleton
class FirestoreDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveAcceptedOrder({
    required OrderEntity order,
    required DriverProfileResponseModel driver,
  }) async {
    await _firestore.collection('accepted_orders').doc(order.orderId).set({
      'status': 'Picked',
      'acceptedAt': DateTime.now().toIso8601String(),
      // Order data
      'orderId': order.orderId,
      'orderNumber': order.orderNumber,
      'totalPrice': order.totalPrice,
      'storeName': order.storeName,
      'storeImage': order.storeImage,
      'storeAddress': order.storeAddress,
      'userName': order.userName,
      'userPhoto': order.userPhoto,
      'userAddress': order.userAddress,
      'userId': order.userId,
      'paymentMethod': order.paymentMethod,
      'items': order.items
              ?.map((i) => {
                    'itemTitle': i.itemTitle,
                    'itemIcon': i.itemIcon,
                    'itemCost': i.itemCost,
                    'itemCount': i.itemCount,
                  })
              .toList() ??
          [],
      // Driver data
      'driverId': driver.id,
      'firstName': driver.firstName,
      'lastName': driver.lastName,
      'phone': driver.phone,
      'email': driver.email,
      'photo': driver.photo,
      'vehicleNumber': driver.vehicleNumber,
    });
  }
}
