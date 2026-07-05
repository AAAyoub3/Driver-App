import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/firebase/services/firestore_service.dart';
import 'package:flowery/modules/order_tracking/api/api_client/order_tracking_api_client.dart';
import 'package:flowery/modules/order_tracking/api/data_sources/order_tracking_remote_data_sources_impl.dart';
import 'package:flowery/modules/order_tracking/data/models/requests/notification_request_model.dart';
import 'package:flowery/modules/order_tracking/data/models/responses/order_item.dart';
import 'package:flowery/modules/order_tracking/data/models/responses/order_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirestoreService extends Mock implements FirestoreService {}

class MockOrderTrackingApiClient extends Mock
    implements OrderTrackingApiClient {}

class FakeNotificationRequestModel extends Fake
    implements NotificationRequestModel {}

void main() {
  late OrderTrackingRemoteDataSourcesImpl dataSource;
  late MockOrderTrackingApiClient mockApiClient;
  late MockFirestoreService mockFirestore;

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

  setUpAll(() {
    registerFallbackValue(FakeNotificationRequestModel());
  });

  setUp(() {
    mockApiClient = MockOrderTrackingApiClient();
    mockFirestore = MockFirestoreService();
    dataSource = OrderTrackingRemoteDataSourcesImpl(
      mockApiClient,
      mockFirestore,
    );
  });

  group('getOrderDetails', () {
    test('returns Success when Firebase call is successful', () async {
      // Arrange
      final mockOrder = order;
      when(
        () => mockFirestore.getOrderFromFirestore(driverId: '123'),
      ).thenAnswer((_) async => mockOrder);

      // Act
      final result = await dataSource.getOrderDetails('123');

      // Assert
      expect(result, isA<Success<OrderModel>>());
    });

    test('returns Error when Firestore throws exception', () async {
      // Arrange
      when(
        () => mockFirestore.getOrderFromFirestore(driverId: '123'),
      ).thenThrow(FirebaseException(plugin: 'firestore'));

      // Act
      final result = await dataSource.getOrderDetails('123');

      // Assert
      expect(result, isA<Error<OrderModel>>());
    });
  });

  group('updateOrderStatus', () {
    test(
      'returns Success after updating order and sending notification',
      () async {
        // Arrange
        final mockOrder = order;

        when(
          () => mockFirestore.updateOrderStateInFirestore(
            orderId: 'o1',
            status: 'delivered',
          ),
        ).thenAnswer((_) async => mockOrder);
        when(
          () => mockFirestore.getUserFcmToken('u1'),
        ).thenAnswer((_) async => 'fcm_token');
        when(
          () => mockFirestore.getAuthTokenForNotification(),
        ).thenAnswer((_) async => 'fake_token');
        when(
          () => mockApiClient.sendNotification(
            authorization: any(named: 'authorization'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => Response(requestOptions: RequestOptions()));

        // Act
        final result = await dataSource.updateOrderStatus(
          'o1',
          'u1',
          'delivered',
          'Title',
        );

        // Assert
        expect(result, isA<Success<OrderModel>>());
        verify(
          () => mockApiClient.sendNotification(
            authorization: any(named: 'authorization'),
            body: any(named: 'body'),
          ),
        ).called(1);
      },
    );
  });
}
