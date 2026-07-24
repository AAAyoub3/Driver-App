import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/auth/data/data_sources/auth_remote_data_source_contract.dart';
import 'package:flowery/modules/auth/data/models/requests/apply_request.dart';
import 'package:flowery/modules/auth/data/models/responses/apply_response.dart';
import 'package:flowery/modules/auth/data/models/responses/country_model.dart';
import 'package:flowery/modules/auth/data/repo/auth_repo_imp.dart';
import 'package:flowery/modules/auth/domain/entities/apply_response_entity.dart';
import 'package:flowery/modules/auth/domain/entities/country_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSourceContract extends Mock
    implements AuthRemoteDataSourceContract {}

void main() {
  late MockAuthRemoteDataSourceContract remoteDataSource;
  late AuthRepoImp repo;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSourceContract();
    repo = AuthRepoImp(remoteDataSource);
    registerFallbackValue(
      ApplyRequest(
        firstName: 'Ahmed',
        lastName: 'Ali',
        email: 'ahmed@example.com',
        phone: '+11234567890',
        password: 'Ahmed@123',
        repassword: 'Ahmed@123',
        gender: 'male',
        country: 'United States',
        vehicleType: '1',
        vehicleNumber: 'ABC123',
        vehicleLicense: XFile('/tmp/license.png'),
        nid: '1234',
        nidImg: XFile('/tmp/id.png'),
      ),
    );
  });

  group('AuthRepoImp tests', () {
    test(
      'sendApplication returns a mapped Success<ApplyResponseEntity>',
      () async {
        final request = ApplyRequest(
          firstName: 'Ahmed',
          lastName: 'Ali',
          email: 'ahmed@example.com',
          phone: '+11234567890',
          password: 'Ahmed@123',
          repassword: 'Ahmed@123',
          gender: 'male',
          country: 'United States',
          vehicleType: '1',
          vehicleNumber: 'ABC123',
          vehicleLicense: XFile('/tmp/license.png'),
          nid: '1234',
          nidImg: XFile('/tmp/id.png'),
        );
        final response = ApplyResponse(
          message: 'success',
          driver: null,
          token: 'token',
        );

        when(
          () => remoteDataSource.sendApplication(request),
        ).thenAnswer((_) async => Success<ApplyResponse>(data: response));

        final result = await repo.sendApplication(request);

        expect(result, isA<Success<ApplyResponseEntity>>());
        expect(
          result.when(success: (data) => data, error: (exception) => null),
          const ApplyResponseEntity(
            message: 'success',
            driver: null,
            token: 'token',
          ),
        );
        verify(() => remoteDataSource.sendApplication(request)).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test('sendApplication returns Error when the datasource fails', () async {
      final request = ApplyRequest(
        firstName: 'Ahmed',
        lastName: 'Ali',
        email: 'ahmed@example.com',
        phone: '+11234567890',
        password: 'Ahmed@123',
        repassword: 'Ahmed@123',
        gender: 'male',
        country: 'United States',
        vehicleType: '1',
        vehicleNumber: 'ABC123',
        vehicleLicense: XFile('/tmp/license.png'),
        nid: '1234',
        nidImg: XFile('/tmp/id.png'),
      );
      final exception = Exception('apply failure');

      when(
        () => remoteDataSource.sendApplication(request),
      ).thenAnswer((_) async => Error<ApplyResponse>(exception: exception));

      final result = await repo.sendApplication(request);

      expect(result, isA<Error<ApplyResponseEntity>>());
      expect(
        result.when(success: (data) => null, error: (exception) => exception),
        exception,
      );
      verify(() => remoteDataSource.sendApplication(request)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test('getCountries returns mapped country entities on success', () async {
      final countryModel = CountryModel(
        isoCode: 'US',
        name: 'United States',
        phoneCode: '1',
        flag: '🇺🇸',
        currency: 'USD',
        latitude: '0',
        longitude: '0',
        timezones: const [],
      );

      when(() => remoteDataSource.getCountries()).thenAnswer(
        (_) async => Success<List<CountryModel>>(data: [countryModel]),
      );

      final result = await repo.getCountries();

      expect(result, isA<Success<List<CountryEntity>>>());
      expect(result.when(success: (data) => data, error: (exception) => null), [
        const CountryEntity(
          isoCode: 'US',
          name: 'United States',
          phoneCode: '1',
          flag: '🇺🇸',
          currency: 'USD',
          latitude: '0',
          longitude: '0',
          timezones: [],
        ),
      ]);
      verify(() => remoteDataSource.getCountries()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test('getCountries returns Error when the datasource fails', () async {
      final exception = Exception('countries failure');

      when(() => remoteDataSource.getCountries()).thenAnswer(
        (_) async => Error<List<CountryModel>>(exception: exception),
      );

      final result = await repo.getCountries();

      expect(result, isA<Error<List<CountryEntity>>>());
      expect(
        result.when(success: (data) => null, error: (exception) => exception),
        exception,
      );
      verify(() => remoteDataSource.getCountries()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
