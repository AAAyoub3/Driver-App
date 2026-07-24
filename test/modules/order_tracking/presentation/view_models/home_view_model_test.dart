import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/core/services/location_service.dart';
import 'package:flowery/modules/order_tracking/domain/entity/home_entity/order_entity.dart';
import 'package:flowery/modules/order_tracking/domain/entity/home_entity/paginated_orders_entity.dart';
import 'package:flowery/modules/order_tracking/domain/repo/profile_repo_contract.dart';
import 'package:flowery/modules/order_tracking/domain/use_case/accept_order_use_case.dart';
import 'package:flowery/modules/order_tracking/domain/use_case/get_orders_use_case.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/cubit/home_view_model.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/events/home_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_view_model_test.mocks.dart';

const fakeOrder = OrderEntity(orderId: 'order123', orderNumber: '#001');

final fakePaginatedOrders = PaginatedOrdersEntity(
  orders: [fakeOrder],
  currentPage: 1,
  totalPages: 1,
  hasMore: false,
);

@GenerateMocks([OrderTrackingRepoContract, LocationService])
void main() {
  late MockOrderTrackingRepoContract mockRepo;
  late MockLocationService mockLocationService;
  late HomeViewModel viewModel;

  setUpAll(() {
    provideDummy<Result<PaginatedOrdersEntity>>(Error<PaginatedOrdersEntity>());
    provideDummy<Result<String>>(Error<String>());
    provideDummy<OrderEntity>(const OrderEntity());
  });

  setUp(() {
    mockRepo = MockOrderTrackingRepoContract();
    mockLocationService = MockLocationService();

    when(mockRepo.getOrders(page: anyNamed('page'))).thenAnswer(
      (_) async => Success(data: fakePaginatedOrders),
    );

    viewModel = HomeViewModel(
      GetOrdersUseCase(mockRepo),
      AcceptOrderUseCase(mockRepo),
      mockLocationService,
    );
  });

  tearDown(() => viewModel.close());

  group('HomeViewModel getOrders', () {
    test('constructor triggers getOrders automatically', () async {
      await Future.delayed(Duration.zero);

      expect(viewModel.state.ordersState.state, StateType.success);
      verify(mockRepo.getOrders(page: anyNamed('page'))).called(1);
    });

    test('emits loading then success on GetOrdersEvent', () async {
      await Future.delayed(Duration.zero);

      when(mockRepo.getOrders(page: anyNamed('page'))).thenAnswer(
        (_) async => Success(data: fakePaginatedOrders),
      );

      final states = <bool>[];
      viewModel.stream.listen((s) => states.add(s.isLoading));

      viewModel.doEvent(GetOrdersEvent());
      await Future.delayed(Duration.zero);

      expect(states, contains(true));
      expect(viewModel.state.isLoading, false);
      expect(viewModel.state.ordersState.state, StateType.success);
    });

    test('emits loading then error on GetOrdersEvent failure', () async {
      await Future.delayed(Duration.zero);

      when(mockRepo.getOrders(page: anyNamed('page'))).thenAnswer(
        (_) async => Error(exception: Exception('network error')),
      );

      viewModel.doEvent(GetOrdersEvent());
      await Future.delayed(Duration.zero);

      expect(viewModel.state.isLoading, false);
      expect(viewModel.state.ordersState.state, StateType.error);
    });
  });

  group('HomeViewModel rejectOrder', () {
    test('removes order from list on RejectOrderEvent', () async {
      await Future.delayed(Duration.zero);

      viewModel.doEvent(RejectOrderEvent(orderId: 'order123'));
      await Future.delayed(Duration.zero);

      final orders = viewModel.state.ordersState.data?.orders ?? [];
      expect(orders.any((o) => o.orderId == 'order123'), false);
    });
  });

  group('HomeViewModel acceptOrder', () {
    test('starts location tracking when accept succeeds', () async {
      await Future.delayed(Duration.zero);

      when(mockRepo.acceptOrder(any)).thenAnswer(
        (_) async => const Success(data: 'driver123'),
      );
      when(mockLocationService.startTracking(any)).thenAnswer((_) async {});

      viewModel.doEvent(AcceptOrderEvent(order: fakeOrder));
      await Future.delayed(Duration.zero);

      verify(mockLocationService.startTracking('driver123')).called(1);
      expect(viewModel.state.isLoading, false);
    });

    test('sets error message when accept fails', () async {
      await Future.delayed(Duration.zero);

      when(mockRepo.acceptOrder(any)).thenAnswer(
        (_) async => Error(exception: Exception('accept failed')),
      );

      viewModel.doEvent(AcceptOrderEvent(order: fakeOrder));
      await Future.delayed(Duration.zero);

      expect(viewModel.state.isLoading, false);
      expect(viewModel.state.acceptErrorMessage, isNotNull);
    });

    test('does not start tracking when driverId is empty', () async {
      await Future.delayed(Duration.zero);

      when(mockRepo.acceptOrder(any)).thenAnswer(
        (_) async => const Success(data: ''),
      );

      viewModel.doEvent(AcceptOrderEvent(order: fakeOrder));
      await Future.delayed(Duration.zero);

      verifyNever(mockLocationService.startTracking(any));
    });
  });
}
