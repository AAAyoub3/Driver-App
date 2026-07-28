import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/auth/data/data_sources/vehicles_remote_data_source_contract.dart';
import 'package:flowery/modules/auth/data/models/responses/vehicle_model.dart';
import 'package:flowery/modules/auth/data/repo/vehicles_repo_imp.dart';
import 'package:flowery/modules/auth/domain/entities/vehicle_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockVehiclesRemoteDataSourceContract extends Mock
    implements VehiclesRemoteDataSourceContract {}

void main() {
  late MockVehiclesRemoteDataSourceContract remoteDataSource;
  late VehiclesRepoImp repo;

  setUp(() {
    remoteDataSource = MockVehiclesRemoteDataSourceContract();
    repo = VehiclesRepoImp(remoteDataSource);
  });

  group('VehiclesRepoImp tests', () {
    test('getVehicles returns mapped vehicle entities on success', () async {
      final vehicle = Vehicle(id: '1', type: 'Sedan');

      when(
        () => remoteDataSource.getVehicles(),
      ).thenAnswer((_) async => Success<List<Vehicle>>(data: [vehicle]));

      final result = await repo.getVehicles();

      expect(result, isA<Success<List<VehicleEntity>>>());
      expect(result.when(success: (data) => data, error: (exception) => null), [
        const VehicleEntity(id: '1', type: 'Sedan'),
      ]);
      verify(() => remoteDataSource.getVehicles()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test('getVehicles returns Error when the datasource fails', () async {
      final exception = Exception('vehicles failure');

      when(
        () => remoteDataSource.getVehicles(),
      ).thenAnswer((_) async => Error<List<Vehicle>>(exception: exception));

      final result = await repo.getVehicles();

      expect(result, isA<Error<List<VehicleEntity>>>());
      expect(
        result.when(success: (data) => null, error: (exception) => exception),
        exception,
      );
      verify(() => remoteDataSource.getVehicles()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
