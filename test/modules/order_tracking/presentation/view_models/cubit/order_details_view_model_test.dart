import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/order_tracking/data/models/responses/order_model.dart';
import 'package:flowery/modules/order_tracking/domain/use_cases/get_order_details_use_case.dart';
import 'package:flowery/modules/order_tracking/domain/use_cases/update_order_state_use_case.dart';
import 'package:flowery/modules/order_tracking/presentation/helpers/order_states_helper.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/cubit/order_details_view_model.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/events/order_details_events.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/states/order_details_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetOrderDetailsUseCase extends Mock
    implements GetOrderDetailsUseCase {}

class MockUpdateOrderStateUseCase extends Mock
    implements UpdateOrderStateUseCase {}

void main() {
  late MockGetOrderDetailsUseCase getOrderDetailsUseCase;
  late MockUpdateOrderStateUseCase updateOrderStateUseCase;
  late OrderDetailsViewModel viewModel;

  const fakeOrder = OrderModel(
    acceptedAt: '',
    driverId: '',
    email: '',
    firstName: '',
    lastName: '',
    orderId: '',
    orderNumber: '',
    phone: '',
    photo: '',
    status: '',
    storeAddress: '',
    storeImage: '',
    storeName: '',
    totalPrice: 0,
    userAddress: '',
    userName: '',
    userPhoto: '',
    userId: '',
    vehicleNumber: '',
    paymentMethod: '',
    items: [],
  );

  setUp(() {
    getOrderDetailsUseCase = MockGetOrderDetailsUseCase();
    updateOrderStateUseCase = MockUpdateOrderStateUseCase();

    viewModel = OrderDetailsViewModel(
      getOrderDetailsUseCase,
      updateOrderStateUseCase,
    );
  });

  group('OrderDetailsViewModel', () {
    test('initial state', () {
      expect(
        viewModel.state,
        const OrderDetailsState(
          currentOrderState: OrderStates.firstState,
        ),
      );
    });

    blocTest<OrderDetailsViewModel, OrderDetailsState>(
      'first -> second',
      build: () {
        when(
          () => updateOrderStateUseCase.call(any(), any(), any(), any()),
        ).thenAnswer(
          (_) async => const Success<OrderModel>(data: fakeOrder),
        );

        return viewModel;
      },
      act: (cubit) => cubit.doEvent(
         UpdateOrderStateEvent(
          orderId: '',
          userId: '',
          title: '',
          currentOrderState: OrderStates.firstState,
        ),
      ),
      expect: () => [
        const OrderDetailsState(isUpdatingOrderStatus: true),
        const OrderDetailsState(
          isUpdatingOrderStatus: true,
          currentOrderState: OrderStates.secondState,
        ),
        const OrderDetailsState(
          currentOrderState: OrderStates.secondState,
          isUpdatingOrderStatus: false,
          order: fakeOrder,
        ),
      ],
    );

    blocTest<OrderDetailsViewModel, OrderDetailsState>(
      'second -> third',
      build: () {
        when(
          () => updateOrderStateUseCase.call(any(), any(), any(), any()),
        ).thenAnswer(
          (_) async => const Success<OrderModel>(data: fakeOrder),
        );

        return viewModel;
      },
      act: (cubit) => cubit.doEvent(
         UpdateOrderStateEvent(
          orderId: '',
          userId: '',
          title: '',
          currentOrderState: OrderStates.secondState,
        ),
      ),
      expect: () => [
        const OrderDetailsState(isUpdatingOrderStatus: true),
        const OrderDetailsState(
          isUpdatingOrderStatus: true,
          currentOrderState: OrderStates.thirdState,
        ),
        const OrderDetailsState(
          currentOrderState: OrderStates.thirdState,
          isUpdatingOrderStatus: false,
          order: fakeOrder,
        ),
      ],
    );

    blocTest<OrderDetailsViewModel, OrderDetailsState>(
      'third -> fourth',
      build: () {
        when(
          () => updateOrderStateUseCase.call(any(), any(), any(), any()),
        ).thenAnswer(
          (_) async => const Success<OrderModel>(data: fakeOrder),
        );

        return viewModel;
      },
      act: (cubit) => cubit.doEvent(
         UpdateOrderStateEvent(
          orderId: '',
          userId: '',
          title: '',
          currentOrderState: OrderStates.thirdState,
        ),
      ),
      expect: () => [
        const OrderDetailsState(isUpdatingOrderStatus: true),
        const OrderDetailsState(
          isUpdatingOrderStatus: true,
          currentOrderState: OrderStates.fourthState,
        ),
        const OrderDetailsState(
          currentOrderState: OrderStates.fourthState,
          isUpdatingOrderStatus: false,
          order: fakeOrder,
        ),
      ],
    );

    blocTest<OrderDetailsViewModel, OrderDetailsState>(
      'fourth -> fifth',
      build: () {
        when(
          () => updateOrderStateUseCase.call(any(), any(), any(), any()),
        ).thenAnswer(
          (_) async => const Success<OrderModel>(data: fakeOrder),
        );

        return viewModel;
      },
      act: (cubit) => cubit.doEvent(
         UpdateOrderStateEvent(
          orderId: '',
          userId: '',
          title: '',
          currentOrderState: OrderStates.fourthState,
        ),
      ),
      expect: () => [
        const OrderDetailsState(isUpdatingOrderStatus: true),
        const OrderDetailsState(
          isUpdatingOrderStatus: true,
          currentOrderState: OrderStates.fifthState,
        ),
        const OrderDetailsState(
          currentOrderState: OrderStates.fifthState,
          isUpdatingOrderStatus: false,
          order: fakeOrder,
        ),
      ],
    );
  });
}