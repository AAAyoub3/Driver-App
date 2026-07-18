import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/order_tracking/data/data_sources/order_tracking_remote_data_sources_contract.dart';
import 'package:flowery/modules/order_tracking/data/models/responses/order_item.dart';
import 'package:flowery/modules/order_tracking/data/models/responses/order_model.dart';
import 'package:flowery/modules/order_tracking/data/repo/order_tracking_repo_impl.dart';

class MockOrderTrackingRemoteDataSources extends Mock
    implements OrderTrackingRemoteDataSourcesContract {}

void main() {
  late MockOrderTrackingRemoteDataSources remoteDataSource;
  late OrderTrackingRepoImpl repo;

  final order = OrderModel(
    acceptedAt: "",
    driverId: "driverId",
    email: "",
    firstName: "",
    lastName: "",
    orderId: "order1",
    orderNumber: "1001",
    phone: "",
    photo: "",
    status: "Pending",
    storeAddress: "",
    storeImage: "",
    storeName: "",
    totalPrice: 100,
    userAddress: "",
    userName: "",
    userPhoto: "",
    userId: "user1",
    vehicleNumber: "",
    paymentMethod: "Cash",
    items: [
      OrderItem(
        itemCost: "50",
        itemCount: "2",
        itemIcon: "",
        itemTitle: "Rose",
      ),
    ],
  );

  setUp(() {
    remoteDataSource = MockOrderTrackingRemoteDataSources();
    repo = OrderTrackingRepoImpl(remoteDataSource);
  });

  group('getOrderDetails', () {
    test('returns Success', () async {
      when(
        () => remoteDataSource.getOrderDetails(any()),
      ).thenAnswer((_) async => Success<OrderModel>(data: order));

      final result = await repo.getOrderDetails("driverId");

      expect(result, isA<Success<OrderModel>>());

      verify(
        () => remoteDataSource.getOrderDetails("driverId"),
      ).called(1);
    });

    test('returns Error', () async {
      final exception = Exception("error");

      when(
        () => remoteDataSource.getOrderDetails(any()),
      ).thenAnswer((_) async => Error<OrderModel>(exception: exception));

      final result = await repo.getOrderDetails("driverId");

      expect(result, isA<Error<OrderModel>>());

      verify(
        () => remoteDataSource.getOrderDetails("driverId"),
      ).called(1);
    });
  });

  group('updateOrderStatus', () {
    test('returns Success', () async {
      when(
        () => remoteDataSource.updateOrderStatus(
          any(),
          any(),
          any(),
          any(),
        ),
      ).thenAnswer((_) async => Success<OrderModel>(data: order));

      final result = await repo.updateOrderStatus(
        "order1",
        "user1",
        "Picked",
        "Order Status",
      );

      expect(result, isA<Success<OrderModel>>());

      verify(
        () => remoteDataSource.updateOrderStatus(
          "order1",
          "user1",
          "Picked",
          "Order Status",
        ),
      ).called(1);
    });

    test('returns Error', () async {
      final exception = Exception("error");

      when(
        () => remoteDataSource.updateOrderStatus(
          any(),
          any(),
          any(),
          any(),
        ),
      ).thenAnswer((_) async => Error<OrderModel>(exception: exception));

      final result = await repo.updateOrderStatus(
        "order1",
        "user1",
        "Picked",
        "Order Status",
      );

      expect(result, isA<Error<OrderModel>>());

      verify(
        () => remoteDataSource.updateOrderStatus(
          "order1",
          "user1",
          "Picked",
          "Order Status",
        ),
      ).called(1);
    });
  });
}