import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/modules/order_tracking/data/models/responses/order_model.dart';

abstract interface class OrderTrackingRepoContract {
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
