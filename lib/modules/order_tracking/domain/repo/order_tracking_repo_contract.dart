import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/order_tracking/domain/entities/driver_orders_response_entity.dart';
import 'package:flowery/modules/order_tracking/data/models/responses/order_model.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
abstract interface class OrderTrackingRepoContract {
  Future<Result<DriverOrdersResponseEntity>> getOrders();
    Future<void> startTracking(String driverId);
  Future<Result<String>> getUserLanguage(String userId);
  Future<void> stopTracking();
  Future<Result<OrderModel>> getOrderDetails(
    String driverId,
    AppLocalizations localizations,
  );
  Future<Result<OrderModel>> updateOrderStatus(
    String orderId,
    String userId,
    String status,
    String title,
    AppLocalizations localizations,
    String userMessage
  );
}