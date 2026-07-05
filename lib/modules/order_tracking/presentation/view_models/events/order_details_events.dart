import 'package:flowery/modules/order_tracking/presentation/helpers/order_states_helper.dart';

sealed class OrderDetailsEvents {}

class UpdateOrderStateEvent extends OrderDetailsEvents {
  final String orderId;
  final String userId;
  final OrderStates currentOrderState;
  final String title;
  UpdateOrderStateEvent({
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
