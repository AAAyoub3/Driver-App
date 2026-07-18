import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/order_tracking/domain/entities/driver_order_entity.dart';
import 'package:flowery/modules/order_tracking/domain/entities/driver_orders_response_entity.dart';
import 'package:flowery/modules/order_tracking/domain/entities/product_entity.dart';
import 'package:flowery/modules/order_tracking/domain/entities/store_entity.dart';
import 'package:flowery/modules/order_tracking/domain/entities/user_entity.dart';
import 'package:flowery/modules/order_tracking/domain/use_case/order_tracking_use_case.dart';
import 'package:flowery/modules/order_tracking/presentation/view_model/base_state/order_tracking_state.dart';
import 'package:flowery/modules/order_tracking/presentation/view_model/cubit/order_tracking_view_model.dart';
import 'package:flowery/modules/order_tracking/presentation/view_model/events/order_tracking_events.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOrderTrackingUseCase extends Mock implements OrderTrackingUseCase {}

void main() {
  late MockOrderTrackingUseCase mockUseCase;
  late OrderTrackingViewModel viewModel;

  const tOrderEntity = OrderEntity(
    id: 'order1',
    user: UserEntity(
      id: 'user1',
      firstName: 'Omar',
      lastName: 'Khaled',
      photo: 'default-profile.png',
    ),
    orderItems: [
      OrderItemEntity(
        product: ProductEntity(id: 'p1', price: 500),
        price: 500,
        quantity: 1,
        id: 'item1',
      ),
    ],
    totalPrice: 300,
    paymentType: 'cash',
    isPaid: false,
    isDelivered: false,
    state: 'completed',
    orderNumber: '#123624',
  );

  const tStore = StoreEntity(
    name: 'Elevate FlowerApp Store',
    image: 'https://www.elevateegy.com/elevate.png',
    address: '123 Fixed Address, City, Country',
    phoneNumber: '1234567890',
    latLong: '37.7749,-122.4194',
  );

  const tDriverOrder = DriverOrderEntity(
    id: 'd1',
    driverId: 'driver1',
    order: tOrderEntity,
    store: tStore,
  );

  const tDriverOrdersResponseEntity = DriverOrdersResponseEntity(
    message: 'success',
    metadata: MetadataEntity(
      currentPage: 1,
      totalPages: 1,
      totalItems: 1,
      limit: 10,
    ),
    orders: [tDriverOrder],
  );

  setUp(() {
    mockUseCase = MockOrderTrackingUseCase();
    viewModel = OrderTrackingViewModel(mockUseCase);
  });

  tearDown(() {
    viewModel.close();
  });

  test('first state is correct', () {
    expect(viewModel.state, const OrderTrackingState());
  });

  group('GetOrdersEvent', () {
    blocTest<OrderTrackingViewModel, OrderTrackingState>(
     '[loading, loaded]',
      build: () {
        when(() => mockUseCase.call()).thenAnswer(
          (_) async =>
              const Success<DriverOrdersResponseEntity>(data: tDriverOrdersResponseEntity),
        );
        return viewModel;
      },
      act: (cubit) => cubit.doEvent(GetOrdersEvent()),
      expect: () => [
        const OrderTrackingState(isLoadingOrders: true, orders: []),
        const OrderTrackingState(
          isLoadingOrders: false,
          orders: [tDriverOrder],
        ),
      ],
      verify: (_) {
        verify(() => mockUseCase.call()).called(1);
      },
    );

    blocTest<OrderTrackingViewModel, OrderTrackingState>(
      '[leding,error]',
      build: () {
        when(() => mockUseCase.call()).thenAnswer(
          (_) async => Error<DriverOrdersResponseEntity>(
            exception: Exception('Something went wrong'),
          ),
        );
        return viewModel;
      },
      act: (cubit) => cubit.doEvent(GetOrdersEvent()),
      expect: () => [
        const OrderTrackingState(isLoadingOrders: true, orders: []),
        isA<OrderTrackingState>()
            .having((s) => s.isLoadingOrders, 'isLoadingOrders', false)
            .having((s) => s.orders, 'orders', isEmpty)
            .having(
              (s) => s.errorMessage,
              'errorMessage',
              contains('Something went wrong'),
            ),
      ],
      verify: (_) {
        verify(() => mockUseCase.call()).called(1);
      },
    );

    blocTest<OrderTrackingViewModel, OrderTrackingState>(
      'empty state',
      build: () {
        when(() => mockUseCase.call()).thenAnswer(
          (_) async => const Success<DriverOrdersResponseEntity>(
            data: DriverOrdersResponseEntity(
              message: 'success',
              metadata: MetadataEntity(
                currentPage: 1,
                totalPages: 1,
                totalItems: 0,
                limit: 10,
              ),
              orders: [],
            ),
          ),
        );
        return viewModel;
      },
      act: (cubit) => cubit.doEvent(GetOrdersEvent()),
      expect: () => [
        const OrderTrackingState(isLoadingOrders: true, orders: []),
        const OrderTrackingState(isLoadingOrders: false, orders: []),
      ],
    );

    blocTest<OrderTrackingViewModel, OrderTrackingState>(
      'error massage',
      build: () {
        when(() => mockUseCase.call()).thenAnswer(
          (_) async =>
              const Success<DriverOrdersResponseEntity>(data: tDriverOrdersResponseEntity),
        );
        return viewModel;
      },
      seed: () => const OrderTrackingState(errorMessage: 'old error'),
      act: (cubit) => cubit.doEvent(GetOrdersEvent()),
      expect: () => [
        const OrderTrackingState(
          isLoadingOrders: true,
          orders: [],
          errorMessage: null,
        ),
        const OrderTrackingState(
          isLoadingOrders: false,
          orders: [tDriverOrder],
        ),
      ],
    );
  });
}