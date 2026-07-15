import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/order_tracking/data/models/responses/order_model.dart';
import 'package:flowery/modules/order_tracking/domain/use_cases/get_order_details_use_case.dart';
import 'package:flowery/modules/order_tracking/domain/use_cases/get_user_language_use_case.dart';
import 'package:flowery/modules/order_tracking/domain/use_cases/start_driver_tracking_use_case.dart';
import 'package:flowery/modules/order_tracking/domain/use_cases/stop_driver_tracking_use_case.dart';
import 'package:flowery/modules/order_tracking/domain/use_cases/update_order_state_use_case.dart';
import 'package:flowery/modules/order_tracking/presentation/helpers/order_states_helper.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/events/order_details_events.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/states/order_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrderDetailsViewModel extends Cubit<OrderDetailsState> {
  final StartDriverTrackingUseCase _startDriverTrackingUseCase;
  final StopDriverTrackingUseCase _stopDriverTrackingUseCase;
  final GetOrderDetailsUseCase _getOrderDetailsUseCase;
  final UpdateOrderStateUseCase _updateOrderStateUseCase;
  final GetUserLanguageUseCase _getUserLanguageUseCase;
  OrderDetailsViewModel(
    this._getOrderDetailsUseCase,
    this._updateOrderStateUseCase,
    this._startDriverTrackingUseCase,
    this._stopDriverTrackingUseCase,
    this._getUserLanguageUseCase,
  ) : super(OrderDetailsState());

  void doEvent(OrderDetailsEvents event) {
    switch (event) {
      case UpdateOrderStateEvent():
        _updateOrderState(event);
      case GetOrderDetailsEvent():
        _getOrderDetails(event);
      case GetUserLanguageEvent():
        _getUserLanguage(event);
    }
  }

  Future<void> _getUserLanguage(GetUserLanguageEvent event) async {
    final response = await _getUserLanguageUseCase.call(event.userId);
    switch (response) {
      case Success<String>():
        emit(state.copyWith(userLang: response.data));
      case Error<String>():
        emit(state.copyWith(errorMessage: response.exception.toString()));
    }
  }

  Future<void> _getOrderDetails(GetOrderDetailsEvent event) async {
    // Start the driver tracking
    await _startDriverTrackingUseCase.call(event.driverId);

    // Getting the order information
    emit(state.copyWith(isLoadingOrder: true));
    final response = await _getOrderDetailsUseCase.call(
      event.driverId,
      event.localizations,
    );
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
    if (event.currentOrderState == OrderStates.accepted) {
      emit(state.copyWith(currentOrderState: OrderStates.picked));
    } else if (event.currentOrderState == OrderStates.picked) {
      emit(state.copyWith(currentOrderState: OrderStates.outForDelivery));
    } else if (event.currentOrderState == OrderStates.outForDelivery) {
      emit(state.copyWith(currentOrderState: OrderStates.arrived));
    } else {
      emit(state.copyWith(currentOrderState: OrderStates.delivered));
      await _stopDriverTrackingUseCase.call();
    }

    final response = await _updateOrderStateUseCase.call(
      event.orderId,
      event.userId,
      state.currentOrderState.statusTextKey,
      event.title,
      event.localizations,
      event.messageSentToUser
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
