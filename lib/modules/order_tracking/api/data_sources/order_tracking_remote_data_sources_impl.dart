import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/firebase/firebase_services.dart';
import 'package:flowery/modules/order_tracking/api/api_client/order_tracking_api_client.dart';
import 'package:flowery/modules/order_tracking/data/data_sources/order_tracking_remote_data_sources_contract.dart';
import 'package:flowery/modules/order_tracking/data/models/order_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrderTrackingRemoteDataSourcesContract)
class OrderTrackingRemoteDataSourcesImpl
    extends OrderTrackingRemoteDataSourcesContract {
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
  Future<Result<OrderModel>> updateOrderStatus(String orderId, String status) async {
        try {
      final response = await firebase.firestore.updateOrderStateInFirestore(
      orderId: orderId,
      status: status,
    );
      return Success<OrderModel>(data: response);
    } catch (e) {
      return Error<OrderModel>(exception: Exception(e.toString()));
    }
  }
}
