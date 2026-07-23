import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/auth/api/clients/api_client/vehicles_api_client.dart';
import 'package:flowery/modules/auth/api/data_source/vehicles_remote_data_source_imp.dart';
import 'package:flowery/modules/auth/data/models/responses/vehicle_model.dart';
import 'package:flowery/modules/auth/data/models/responses/vehicles_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockVehiclesApiClient extends Mock implements VehiclesApiClient {}

void main() {
  late MockVehiclesApiClient apiClient;
  late VehiclesRemoteDataSourceImp remoteDataSource;

  setUp(() {
    apiClient = MockVehiclesApiClient();
    remoteDataSource = VehiclesRemoteDataSourceImp(apiClient);
  });

  group('VehiclesRemoteDataSourceImp tests', () {
    test(
      'getVehicles returns Success<List<Vehicle>> when api client succeeds',
      () async {
        final response = VehiclesResponse(
          message: 'success',
          vehicles: [Vehicle(id: '1', type: 'Sedan')],
        );

        when(() => apiClient.getVehicles()).thenAnswer((_) async => response);

        final result = await remoteDataSource.getVehicles();

        expect(result, isA<Success<List<Vehicle>>>());
        expect(
          result.when(success: (data) => data, error: (exception) => null),
          response.vehicles,
        );
        verify(() => apiClient.getVehicles()).called(1);
        verifyNoMoreInteractions(apiClient);
      },
    );

    test('getVehicles returns Error<List<Vehicle>> on DioException', () async {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/vehicles'),
        error: 'vehicles failed',
      );

      when(() => apiClient.getVehicles()).thenThrow(exception);

      final result = await remoteDataSource.getVehicles();

      expect(result, isA<Error<List<Vehicle>>>());
      verify(() => apiClient.getVehicles()).called(1);
      verifyNoMoreInteractions(apiClient);
    });
  });
}
