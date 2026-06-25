import 'package:flowery/modules/order_tracking/presentation/screens/order_details_screen.dart';

sealed class OrderDetailsEvents {}

class NextOrderStateEvent extends OrderDetailsEvents {
  final OrderStates currentOrderState;
  NextOrderStateEvent({required this.currentOrderState});
}
