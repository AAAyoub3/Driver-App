import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/order_tracking/data/models/responses/order_model.dart';
import 'package:flowery/modules/order_tracking/domain/use_cases/get_order_details_use_case.dart';
import 'package:flowery/modules/order_tracking/domain/use_cases/update_order_state_use_case.dart';
import 'package:flowery/modules/order_tracking/presentation/helpers/order_states_helper.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/events/order_details_events.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/states/order_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrderDetailsViewModel extends Cubit<OrderDetailsState> {
  final GetOrderDetailsUseCase _getOrderDetailsUseCase;
  final UpdateOrderStateUseCase _updateOrderStateUseCase;
  OrderDetailsViewModel(
    this._getOrderDetailsUseCase,
    this._updateOrderStateUseCase,
  ) : super(OrderDetailsState());
  void doEvent(OrderDetailsEvents event) {
    switch (event) {
      case UpdateOrderStateEvent():
        _updateOrderState(event);
      case GetOrderDetailsEvent():
        _getOrderDetails(event);
    }
  }

  Future<void> _getOrderDetails(GetOrderDetailsEvent event) async {
    emit(state.copyWith(isLoadingOrder: true));
    final response = await _getOrderDetailsUseCase.call(event.driverId);
    switch (response) {
      case Success<OrderModel>():
        emit(state.copyWith(isLoadingOrder: false, order: response.data));
      case Error<OrderModel>():
        emit(
          state.copyWith(
            isLoadingOrder: false,
            errorMessage: response.exception.toString(),
          ),
        );
    }
  }

  void _updateOrderState(UpdateOrderStateEvent event) async {
    emit(state.copyWith(isUpdatingOrderStatus: true));

    // Switch to the next state before updating in firestore
    if (event.currentOrderState == OrderStates.firstState) {
      emit(state.copyWith(currentOrderState: OrderStates.secondState));
    } else if (event.currentOrderState == OrderStates.secondState) {
      emit(state.copyWith(currentOrderState: OrderStates.thirdState));
    } else if (event.currentOrderState == OrderStates.thirdState) {
      emit(state.copyWith(currentOrderState: OrderStates.fourthState));
    } else {
      emit(state.copyWith(currentOrderState: OrderStates.fifthState));
    }

    final response = await _updateOrderStateUseCase.call(
      event.orderId,
      event.userId,
      state.currentOrderState.statusText,
      event.title,
    );

    switch (response) {
      case Success<OrderModel>():
        emit(
          state.copyWith(isUpdatingOrderStatus: false, order: response.data),
        );
      case Error<OrderModel>():
        emit(
          state.copyWith(
            isUpdatingOrderStatus: false,
            errorMessage: response.exception.toString(),
          ),
        );
    }
  }
}
