import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/order_tracking/api/api_client/order_tracking_api_client.dart';
import 'package:flowery/modules/order_tracking/api/data_sources/order_tracking_remote_data_sources_impl.dart';
import 'package:flowery/modules/order_tracking/data/model/driver_profile_response_model.dart';
import 'package:flowery/modules/order_tracking/data/model/home_response_models/home_respnose_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'order_tracking_data_source_test.mocks.dart';

@GenerateMocks([OrderTrackingApiClient])
void main() {
  late MockOrderTrackingApiClient mockApiClient;
  late OrderTrackingRemoteDataSourcesImpl dataSource;

  setUp(() {
    mockApiClient = MockOrderTrackingApiClient();
    dataSource = OrderTrackingRemoteDataSourcesImpl(mockApiClient);
  });

  group('OrderTrackingRemoteDataSourcesImpl getHomeData', () {
    test('returns success when api works', () async {
      when(mockApiClient.getHomeData(any)).thenAnswer(
        (_) async => const HomeResponseModel(message: 'ok', orders: []),
      );

      final result = await dataSource.getHomeData(page: 1);

      expect(result, isA<Success<HomeResponseModel>>());
    });

    test('returns error when api throws DioException', () async {
      when(mockApiClient.getHomeData(any)).thenThrow(
        DioException(requestOptions: RequestOptions(path: '')),
      );

      final result = await dataSource.getHomeData(page: 1);

      expect(result, isA<Error<HomeResponseModel>>());
    });

    test('returns error when api throws generic exception', () async {
      when(mockApiClient.getHomeData(any)).thenThrow(Exception('network error'));

      final result = await dataSource.getHomeData(page: 1);

      expect(result, isA<Error<HomeResponseModel>>());
    });
  });

  group('OrderTrackingRemoteDataSourcesImpl getDriverProfile', () {
    test('returns success when api works', () async {
      when(mockApiClient.getDriverProfile()).thenAnswer(
        (_) async => DriverProfileResponseModel(id: 'driver123'),
      );

      final result = await dataSource.getDriverProfile();

      expect(result, isA<Success<DriverProfileResponseModel>>());
      expect((result as Success<DriverProfileResponseModel>).data?.id, 'driver123');
    });

    test('returns error when api throws exception', () async {
      when(mockApiClient.getDriverProfile()).thenThrow(Exception('unauthorized'));

      final result = await dataSource.getDriverProfile();

      expect(result, isA<Error<DriverProfileResponseModel>>());
    });
  });

  group('OrderTrackingRemoteDataSourcesImpl startOrder', () {
    test('returns success when api works', () async {
      when(mockApiClient.startOrder(any)).thenAnswer((_) async {});

      final result = await dataSource.startOrder('order123');

      expect(result, isA<Success<void>>());
    });

    test('returns error when api throws exception', () async {
      when(mockApiClient.startOrder(any)).thenThrow(Exception('failed'));

      final result = await dataSource.startOrder('order123');

      expect(result, isA<Error<void>>());
    });
  });
}
