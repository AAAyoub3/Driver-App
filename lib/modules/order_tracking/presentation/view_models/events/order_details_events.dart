import 'package:flowery/modules/order_tracking/presentation/screens/order_details_screen.dart';

sealed class OrderDetailsEvents {}

class NextOrderStateEvent extends OrderDetailsEvents {
  final String orderId;
  final String userId;
  final OrderStates currentOrderState;
  final String title;
  NextOrderStateEvent({
    required this.orderId,
    required this.userId,
    required this.currentOrderState,
    required this.title,
  });
}

class GetOrderDetailsEvent extends OrderDetailsEvents {
  final String driverId;

  GetOrderDetailsEvent(this.driverId);
}
