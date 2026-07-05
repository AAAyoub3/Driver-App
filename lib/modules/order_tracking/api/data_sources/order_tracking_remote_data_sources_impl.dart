import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/firebase/services/firestore_service.dart';
import 'package:flowery/config/handler/dio_exception_handler.dart';
import 'package:flowery/config/handler/firebase_exception_handler.dart';
import 'package:flowery/modules/order_tracking/api/api_client/order_tracking_api_client.dart';
import 'package:flowery/modules/order_tracking/data/data_sources/order_tracking_remote_data_sources_contract.dart';
import 'package:flowery/modules/order_tracking/data/models/requests/notification_request_model.dart';
import 'package:flowery/modules/order_tracking/data/models/responses/order_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrderTrackingRemoteDataSourcesContract)
class OrderTrackingRemoteDataSourcesImpl
    implements OrderTrackingRemoteDataSourcesContract {
  final FirestoreService firestore;
  final OrderTrackingApiClient apiClient;
  OrderTrackingRemoteDataSourcesImpl(this.apiClient, this.firestore);

  @override
  Future<Result<OrderModel>> getOrderDetails(String driverId) async {
    try {
      final response = await firestore.getOrderFromFirestore(
        driverId: driverId,
      );
      return Success<OrderModel>(data: response);
    } on DioException catch (e) {
      return Error<OrderModel>(exception: DioExceptionHandler.handle(e));
    } on FirebaseException catch (e) {
      return Error<OrderModel>(
        exception: FirebaseExceptionHandler.fromFirestore(e),
      );
    } catch (e) {
      return Error(exception: Exception(e.toString()));
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
      // Update order status in firestore
      final response = await firestore.updateOrderStateInFirestore(
        orderId: orderId,
        status: status,
      );

      // Get the FCM token of the user
      final fcmToken = await firestore.getUserFcmToken(userId);

      // Get the Auth token to send the notification
      final authToken = await firestore.getAuthTokenForNotification();

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
    } on DioException catch (e) {
      return Error<OrderModel>(exception: DioExceptionHandler.handle(e));
    } on FirebaseException catch (e) {
      return Error<OrderModel>(
        exception: FirebaseExceptionHandler.fromFirestore(e),
      );
    } catch (e) {
      return Error(exception: Exception(e.toString()));
    }
  }
}
