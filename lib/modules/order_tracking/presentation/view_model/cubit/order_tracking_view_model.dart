import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/order_tracking/domain/entities/driver_orders_response_entity.dart';
import 'package:flowery/modules/order_tracking/domain/use_case/order_tracking_use_case.dart';
import 'package:flowery/modules/order_tracking/presentation/view_model/base_state/order_tracking_state.dart';
import 'package:flowery/modules/order_tracking/presentation/view_model/events/order_tracking_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrderTrackingViewModel extends Cubit<OrderTrackingState> {
  final OrderTrackingUseCase _orderTrackingUseCase;

  OrderTrackingViewModel(this._orderTrackingUseCase)
    : super(const OrderTrackingState());

  void doEvent(OrderTrackingEvents event) {
    switch (event) {
      case GetOrdersEvent():
        _getOrders();
    }
  }

  Future<void> _getOrders() async {
    emit(state.copyWith(isLoadingOrders: true, errorMessage: null));

    final response = await _orderTrackingUseCase.call();

    switch (response) {
      case Success<DriverOrdersResponseEntity>():
        emit(
          state.copyWith(
            isLoadingOrders: false,
            orders: response.data?.orders ?? [],
          ),
        );
        return;
      case Error<DriverOrdersResponseEntity>():
        emit(
          state.copyWith(
            isLoadingOrders: false,
            errorMessage: response.exception.toString(),
          ),
        );
        return;
    }
  }
}
