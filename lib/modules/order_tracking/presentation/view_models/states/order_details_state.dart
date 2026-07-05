import 'package:equatable/equatable.dart';
import 'package:flowery/modules/order_tracking/data/models/responses/order_model.dart';
import 'package:flowery/modules/order_tracking/presentation/helpers/order_states_helper.dart';

class OrderDetailsState extends Equatable {
  final bool isLoadingOrder;
  final bool isUpdatingOrderStatus;
  final OrderStates currentOrderState;
  final OrderModel? order;
  final String? errorMessage;
  const OrderDetailsState({
    this.isLoadingOrder = true,
    this.isUpdatingOrderStatus = false,
    this.order,
    this.currentOrderState = OrderStates.firstState,
    this.errorMessage,
  });

  OrderDetailsState copyWith({
    final bool? isLoadingOrder,
    final OrderModel? order,
    final OrderStates? currentOrderState,
    final String? errorMessage,
    final bool? isUpdatingOrderStatus,
  }) => OrderDetailsState(
    order: order ?? this.order,
    currentOrderState: currentOrderState ?? this.currentOrderState,
    errorMessage: errorMessage ?? this.errorMessage,
    isLoadingOrder: isLoadingOrder ?? this.isLoadingOrder,
    isUpdatingOrderStatus: isUpdatingOrderStatus ?? this.isUpdatingOrderStatus,
  );
  @override
  List<Object?> get props => [
    currentOrderState,
    order,
    errorMessage,
    isLoadingOrder,
    isUpdatingOrderStatus,
  ];
}
