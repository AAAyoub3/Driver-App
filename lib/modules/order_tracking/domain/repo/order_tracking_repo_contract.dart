import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/order_tracking/domain/entities/driver_orders_response_entity.dart';

abstract class OrderTrackingRepoContract {
  Future<Result<DriverOrdersResponseEntity>> getOrders();
}