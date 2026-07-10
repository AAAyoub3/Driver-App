import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/modules/order_tracking/domain/entity/home_entity/paginated_orders_entity.dart';

class HomeState {
  final bool isLoading;
  final BaseState<PaginatedOrdersEntity> ordersState;
  final String? acceptErrorMessage;

  HomeState({
    this.isLoading = false,
    BaseState<PaginatedOrdersEntity>? ordersState,
    this.acceptErrorMessage,
  }) : ordersState = ordersState ?? const BaseState.initial();

  HomeState copyWith({
    bool? isLoading,
    BaseState<PaginatedOrdersEntity>? ordersState,
    String? acceptErrorMessage,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      ordersState: ordersState ?? this.ordersState,
      acceptErrorMessage: acceptErrorMessage,
    );
  }
}
