import 'package:flowery/modules/order_tracking/presentation/screens/order_details_screen.dart';

sealed class OrderDetailsEvents {}

class NextOrderStateEvent extends OrderDetailsEvents {
  final String orderId;
  final OrderStates currentOrderState;
  NextOrderStateEvent({required this.orderId, required this.currentOrderState});
}

class GetOrderDetailsEvent extends OrderDetailsEvents {
  final String driverId;

  GetOrderDetailsEvent(this.driverId);
}
