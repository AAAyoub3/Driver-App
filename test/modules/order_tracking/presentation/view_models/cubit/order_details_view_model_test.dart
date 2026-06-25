import 'package:flowery/modules/order_tracking/presentation/screens/order_details_screen.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/cubit/order_details_view_model.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/events/order_details_events.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/states/order_details_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('OrderDetailsViewModel', () {
    test('initial state should be firstState', () {
      final cubit = OrderDetailsViewModel();

      expect(
        cubit.state,
        const OrderDetailsState(
          currentOrderState: OrderStates.firstState,
        ),
      );

      cubit.close();
    });

    blocTest<OrderDetailsViewModel, OrderDetailsState>(
      'emits secondState when current state is firstState',
      build: OrderDetailsViewModel.new,
      act: (cubit) {
        cubit.doEvent(
          NextOrderStateEvent(
            currentOrderState: OrderStates.firstState,
          ),
        );
      },
      expect: () => [
        const OrderDetailsState(
          currentOrderState: OrderStates.secondState,
        ),
      ],
    );

    blocTest<OrderDetailsViewModel, OrderDetailsState>(
      'emits thirdState when current state is secondState',
      build: OrderDetailsViewModel.new,
      act: (cubit) {
        cubit.doEvent(
          NextOrderStateEvent(
            currentOrderState: OrderStates.secondState,
          ),
        );
      },
      expect: () => [
        const OrderDetailsState(
          currentOrderState: OrderStates.thirdState,
        ),
      ],
    );

    blocTest<OrderDetailsViewModel, OrderDetailsState>(
      'emits fourthState when current state is thirdState',
      build: OrderDetailsViewModel.new,
      act: (cubit) {
        cubit.doEvent(
          NextOrderStateEvent(
            currentOrderState: OrderStates.thirdState,
          ),
        );
      },
      expect: () => [
        const OrderDetailsState(
          currentOrderState: OrderStates.fourthState,
        ),
      ],
    );

    blocTest<OrderDetailsViewModel, OrderDetailsState>(
      'emits fifthState when current state is fourthState',
      build: OrderDetailsViewModel.new,
      act: (cubit) {
        cubit.doEvent(
          NextOrderStateEvent(
            currentOrderState: OrderStates.fourthState,
          ),
        );
      },
      expect: () => [
        const OrderDetailsState(
          currentOrderState: OrderStates.fifthState,
        ),
      ],
    );

    blocTest<OrderDetailsViewModel, OrderDetailsState>(
      'emits fifthState when current state is fifthState',
      build: OrderDetailsViewModel.new,
      act: (cubit) {
        cubit.doEvent(
          NextOrderStateEvent(
            currentOrderState: OrderStates.fifthState,
          ),
        );
      },
      expect: () => [
        const OrderDetailsState(
          currentOrderState: OrderStates.fifthState,
        ),
      ],
    );
  });
}