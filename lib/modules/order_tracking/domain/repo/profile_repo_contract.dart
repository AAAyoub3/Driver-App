import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/order_tracking/domain/entity/home_entity/order_entity.dart';
import 'package:flowery/modules/order_tracking/domain/entity/home_entity/paginated_orders_entity.dart';

abstract class OrderTrackingRepoContract {
  Future<Result<PaginatedOrdersEntity>> getOrders({int page = 1});
  Future<Result<String>> acceptOrder(OrderEntity order);
}
