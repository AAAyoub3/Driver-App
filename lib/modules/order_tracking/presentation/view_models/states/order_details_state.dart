import 'package:equatable/equatable.dart';
import 'package:flowery/modules/order_tracking/data/models/order_model.dart';
import 'package:flowery/modules/order_tracking/presentation/screens/order_details_screen.dart';

class OrderDetailsState extends Equatable {
  final bool isLoadingOrder;
  final OrderStates currentOrderState;
  final OrderModel? order;
  final String? errorMessage;
  const OrderDetailsState({
    this.isLoadingOrder = true,
    this.order,
    this.currentOrderState = OrderStates.firstState,
    this.errorMessage,
  });

  OrderDetailsState copyWith({
    final bool? isLoadingOrder,
    final OrderModel? order,
    final OrderStates? currentOrderState,
    final String? errorMessage,
  }) => OrderDetailsState(
    order: order ?? this.order,
    currentOrderState: currentOrderState ?? this.currentOrderState,
    errorMessage: errorMessage ?? this.errorMessage,
    isLoadingOrder: isLoadingOrder ?? this.isLoadingOrder,
  );
  @override
  List<Object?> get props => [
    currentOrderState,
    order,
    errorMessage,
    isLoadingOrder,
  ];
}
