import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/config/api/app_endpoints.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/firebase/firebase_services.dart';
import 'package:flowery/modules/order_tracking/api/api_client/order_tracking_api_client.dart';
import 'package:flowery/modules/order_tracking/data/data_sources/order_tracking_remote_data_sources_contract.dart';
import 'package:flowery/modules/order_tracking/data/models/notification_request_model.dart';
import 'package:flowery/modules/order_tracking/data/models/order_model.dart';
import 'package:injectable/injectable.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

@Injectable(as: OrderTrackingRemoteDataSourcesContract)
class OrderTrackingRemoteDataSourcesImpl
    implements OrderTrackingRemoteDataSourcesContract {
  final FirebaseServices firebase;
  final OrderTrackingApiClient apiClient;
  OrderTrackingRemoteDataSourcesImpl(this.apiClient, this.firebase);

  @override
  Future<Result<OrderModel>> getOrderDetails(String driverId) async {
    try {
      final response = await firebase.firestore.getOrderFromFirestore(
        driverId: driverId,
      );
      return Success<OrderModel>(data: response);
    } catch (e) {
      return Error<OrderModel>(exception: Exception(e.toString()));
    }
  }

  @override
  Future<Result<OrderModel>> updateOrderStatus(
    String orderId,
    String userId,
    String status,
    String title,
  ) async {
    try {
      // Update firestore order status
      final response = await firebase.firestore.updateOrderStateInFirestore(
        orderId: orderId,
        status: status,
      );

      // Get the FCM token of the user
      final fcmToken = await firebase.firestore.getUserFcmToken(userId);

      // Get the Auth token to send the notification
      final authToken = await getAuthTokenForNotification();

      // Send Notification to the user using FCM & Auth Tokens
      await apiClient.sendNotification(
        authorization: "${Apikeys.bearer} $authToken",
        body: NotificationRequestModel(
          message: MessageModel(
            token: fcmToken ?? "",
            notification: NotificationModel(title: title, body: status),
          ),
        ),
      );
      return Success<OrderModel>(data: response);
    } catch (e) {
      return Error<OrderModel>(exception: Exception(e.toString()));
    }
  }
}

Future<String> getAuthTokenForNotification() async {
  final jsonString = await rootBundle.loadString(
    "assets/flowery-app-fb297-firebase-adminsdk-fbsvc-087c98b328.json",
  );

  final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
  final accountCredentials = ServiceAccountCredentials.fromJson(jsonMap);
  final scopes = [AppEndPoints.firebaseMessagingScope];
  final client = await clientViaServiceAccount(accountCredentials, scopes);
  return client.credentials.accessToken.data;
}
