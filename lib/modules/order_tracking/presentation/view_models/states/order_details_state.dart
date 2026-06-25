import 'package:equatable/equatable.dart';
import 'package:flowery/modules/order_tracking/presentation/screens/order_details_screen.dart';

class OrderDetailsState extends Equatable {
  final OrderStates currentOrderState;
  const OrderDetailsState({this.currentOrderState = OrderStates.firstState});
  OrderDetailsState copyWith({final OrderStates? currentOrderState}) =>
      OrderDetailsState(currentOrderState: currentOrderState ?? this.currentOrderState);
  @override
  List<Object?> get props => [currentOrderState];
}
