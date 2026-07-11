import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/order_tracking/data/models/response/driver_orders_response.dart';

abstract class OrderTrackingRemoteDataSourcesContract {
  Future<Result<DriverOrdersResponse>> getOrders();
}