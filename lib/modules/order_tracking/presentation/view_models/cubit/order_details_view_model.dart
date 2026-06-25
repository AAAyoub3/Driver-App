import 'package:flowery/modules/order_tracking/presentation/screens/order_details_screen.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/events/order_details_events.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/states/order_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrderDetailsViewModel extends Cubit<OrderDetailsState> {
  OrderDetailsViewModel() : super(OrderDetailsState());
  void doEvent(OrderDetailsEvents event) {
    switch (event) {
      case NextOrderStateEvent():
        _nextOrderState(event);
    }
  }

  void _nextOrderState(NextOrderStateEvent event) {
    if (event.currentOrderState == OrderStates.firstState) {
      emit(OrderDetailsState(currentOrderState: OrderStates.secondState));
    } else if (event.currentOrderState == OrderStates.secondState) {
      emit(OrderDetailsState(currentOrderState: OrderStates.thirdState));
    } else if (event.currentOrderState == OrderStates.thirdState) {
      emit(OrderDetailsState(currentOrderState: OrderStates.fourthState));
    } else {
      emit(OrderDetailsState(currentOrderState: OrderStates.fifthState));
    }
  }
}
