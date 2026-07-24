import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/order_tracking/data/data_sources/firestore_data_source.dart';
import 'package:flowery/modules/order_tracking/data/data_sources/orders_remote_data_sources_contract.dart';
import 'package:flowery/modules/order_tracking/data/model/driver_profile_response_model.dart';
import 'package:flowery/modules/order_tracking/data/model/home_response_models/home_respnose_model.dart';
import 'package:flowery/modules/order_tracking/data/repo/profile_repo_impl.dart';
import 'package:flowery/modules/order_tracking/domain/entity/home_entity/order_entity.dart';
import 'package:flowery/modules/order_tracking/domain/entity/home_entity/paginated_orders_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'order_tracking_repo_impl_test.mocks.dart';

const fakeOrder = OrderEntity(orderId: 'order123', orderNumber: '#001');

@GenerateMocks([OrderTrackingRemoteDataSourcesContract, FirestoreDataSource])
void main() {
  late MockOrderTrackingRemoteDataSourcesContract mockDataSource;
  late MockFirestoreDataSource mockFirestore;
  late OrderTrackingRepoImpl repo;

  setUpAll(() {
    provideDummy<Result<HomeResponseModel>>(Error<HomeResponseModel>());
    provideDummy<Result<void>>(Error<void>());
    provideDummy<Result<DriverProfileResponseModel>>(
      Error<DriverProfileResponseModel>(),
    );
    provideDummy<OrderEntity>(const OrderEntity());
    provideDummy<DriverProfileResponseModel>(DriverProfileResponseModel());
  });

  setUp(() {
    mockDataSource = MockOrderTrackingRemoteDataSourcesContract();
    mockFirestore = MockFirestoreDataSource();
    repo = OrderTrackingRepoImpl(mockDataSource, mockFirestore);
  });

  group('OrderTrackingRepoImpl getOrders', () {
    test('returns PaginatedOrdersEntity when data source succeeds', () async {
      when(mockDataSource.getHomeData(page: anyNamed('page'))).thenAnswer(
        (_) async => const Success(
          data: HomeResponseModel(message: 'ok', orders: []),
        ),
      );

      final result = await repo.getOrders(page: 1);

      expect(result, isA<Success<PaginatedOrdersEntity>>());
      final orders = (result as Success<PaginatedOrdersEntity>).data?.orders;
      expect(orders, isEmpty);
    });

    test('returns error when data source returns error', () async {
      when(mockDataSource.getHomeData(page: anyNamed('page'))).thenAnswer(
        (_) async => Error(exception: Exception('server error')),
      );

      final result = await repo.getOrders(page: 1);

      expect(result, isA<Error<PaginatedOrdersEntity>>());
    });
  });

  group('OrderTrackingRepoImpl acceptOrder', () {
    test('returns driverId when full flow succeeds', () async {
      when(mockDataSource.startOrder(any)).thenAnswer(
        (_) async => Success<void>(data: null),
      );
      when(mockDataSource.getDriverProfile()).thenAnswer(
        (_) async => Success(data: DriverProfileResponseModel(id: 'driver123')),
      );
      when(
        mockFirestore.saveAcceptedOrder(
          order: anyNamed('order'),
          driver: anyNamed('driver'),
        ),
      ).thenAnswer((_) async {});

      final result = await repo.acceptOrder(fakeOrder);

      expect(result, isA<Success<String>>());
      expect((result as Success<String>).data, 'driver123');
    });

    test('returns error when startOrder fails', () async {
      when(mockDataSource.startOrder(any)).thenAnswer(
        (_) async => Error(exception: Exception('start failed')),
      );

      final result = await repo.acceptOrder(fakeOrder);

      expect(result, isA<Error<String>>());
      verifyNever(mockDataSource.getDriverProfile());
    });

    test('returns error when getDriverProfile fails', () async {
      when(mockDataSource.startOrder(any)).thenAnswer(
        (_) async => Success<void>(data: null),
      );
      when(mockDataSource.getDriverProfile()).thenAnswer(
        (_) async => Error(exception: Exception('profile failed')),
      );

      final result = await repo.acceptOrder(fakeOrder);

      expect(result, isA<Error<String>>());
      verifyNever(
        mockFirestore.saveAcceptedOrder(
          order: anyNamed('order'),
          driver: anyNamed('driver'),
        ),
      );
    });
  });
}
