import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/order_tracking/data/models/order_model.dart';

abstract class OrderTrackingRepoContract {
  Future<Result<OrderModel>> getOrderDetails(String driverId);
  Future<Result<OrderModel>> updateOrderStatus(String orderId,String userId, String status);
}
