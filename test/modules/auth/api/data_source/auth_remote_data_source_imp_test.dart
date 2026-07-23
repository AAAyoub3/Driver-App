import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/auth/api/clients/api_client/auth_api_client.dart';
import 'package:flowery/modules/auth/api/clients/local_client/countries_local_client.dart';
import 'package:flowery/modules/auth/api/data_source/auth_remote_data_source_imp.dart';
import 'package:flowery/modules/auth/data/models/requests/apply_request.dart';
import 'package:flowery/modules/auth/data/models/responses/apply_response.dart';
import 'package:flowery/modules/auth/data/models/responses/country_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthApiClient extends Mock implements AuthApiClient {}

class MockCountriesLocalClient extends Mock implements CountriesLocalClient {}

Future<ApplyRequest> _createRequest() async {
  final tempDir = await Directory.systemTemp.createTemp();
  final licenseFile = File('${tempDir.path}/license.png')
    ..writeAsStringSync('license');
  final idFile = File('${tempDir.path}/id.png')..writeAsStringSync('id');

  return ApplyRequest(
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
    vehicleLicense: XFile(licenseFile.path),
    nid: '1234',
    nidImg: XFile(idFile.path),
  );
}

void main() {
  late MockAuthApiClient apiClient;
  late MockCountriesLocalClient localClient;
  late AuthRemoteDataSourceImp remoteDataSource;

  setUpAll(() {
    registerFallbackValue(MultipartFile.fromString('fallback'));
  });

  setUp(() {
    apiClient = MockAuthApiClient();
    localClient = MockCountriesLocalClient();
    remoteDataSource = AuthRemoteDataSourceImp(apiClient, localClient);
  });

  group('AuthRemoteDataSourceImp tests', () {
    test(
      'sendApplication returns Success<ApplyResponse> when api client succeeds',
      () async {
        final request = await _createRequest();
        final response = ApplyResponse(
          message: 'success',
          driver: null,
          token: 'token',
        );

        when(
          () => apiClient.apply(
            firstName: request.firstName,
            lastName: request.lastName,
            email: request.email,
            phone: request.phone,
            password: request.password,
            repassword: request.repassword,
            gender: request.gender,
            country: request.country,
            vehicleType: request.vehicleType,
            vehicleNumber: request.vehicleNumber,
            nid: request.nid,
            vehicleLicense: any(named: 'vehicleLicense'),
            nidImg: any(named: 'nidImg'),
          ),
        ).thenAnswer((_) async => response);

        final result = await remoteDataSource.sendApplication(request);

        expect(result, isA<Success<ApplyResponse>>());
        expect(
          result.when(success: (data) => data, error: (exception) => null),
          response,
        );
        verify(
          () => apiClient.apply(
            firstName: request.firstName,
            lastName: request.lastName,
            email: request.email,
            phone: request.phone,
            password: request.password,
            repassword: request.repassword,
            gender: request.gender,
            country: request.country,
            vehicleType: request.vehicleType,
            vehicleNumber: request.vehicleNumber,
            nid: request.nid,
            vehicleLicense: any(named: 'vehicleLicense'),
            nidImg: any(named: 'nidImg'),
          ),
        ).called(1);
        verifyNoMoreInteractions(apiClient);
      },
    );

    test(
      'sendApplication returns Error<ApplyResponse> on DioException',
      () async {
        final request = await _createRequest();
        final exception = DioException(
          requestOptions: RequestOptions(path: '/apply'),
          error: 'request failed',
        );

        when(
          () => apiClient.apply(
            firstName: request.firstName,
            lastName: request.lastName,
            email: request.email,
            phone: request.phone,
            password: request.password,
            repassword: request.repassword,
            gender: request.gender,
            country: request.country,
            vehicleType: request.vehicleType,
            vehicleNumber: request.vehicleNumber,
            nid: request.nid,
            vehicleLicense: any(named: 'vehicleLicense'),
            nidImg: any(named: 'nidImg'),
          ),
        ).thenThrow(exception);

        final result = await remoteDataSource.sendApplication(request);

        expect(result, isA<Error<ApplyResponse>>());
        verify(
          () => apiClient.apply(
            firstName: request.firstName,
            lastName: request.lastName,
            email: request.email,
            phone: request.phone,
            password: request.password,
            repassword: request.repassword,
            gender: request.gender,
            country: request.country,
            vehicleType: request.vehicleType,
            vehicleNumber: request.vehicleNumber,
            nid: request.nid,
            vehicleLicense: any(named: 'vehicleLicense'),
            nidImg: any(named: 'nidImg'),
          ),
        ).called(1);
        verifyNoMoreInteractions(apiClient);
      },
    );

    test(
      'getCountries returns Success<List<CountryModel>> when local client succeeds',
      () async {
        final country = CountryModel(
          isoCode: 'US',
          name: 'United States',
          phoneCode: '1',
          flag: '🇺🇸',
          currency: 'USD',
          latitude: '0',
          longitude: '0',
          timezones: const [],
        );

        when(
          () => localClient.getCountries(),
        ).thenAnswer((_) async => [country]);

        final result = await remoteDataSource.getCountries();

        expect(result, isA<Success<List<CountryModel>>>());
        expect(
          result.when(success: (data) => data, error: (exception) => null),
          [country],
        );
        verify(() => localClient.getCountries()).called(1);
        verifyNoMoreInteractions(localClient);
      },
    );

    test(
      'getCountries returns Error<List<CountryModel>> when local client throws',
      () async {
        when(
          () => localClient.getCountries(),
        ).thenThrow(Exception('countries failed'));

        final result = await remoteDataSource.getCountries();

        expect(result, isA<Error<List<CountryModel>>>());
        verify(() => localClient.getCountries()).called(1);
        verifyNoMoreInteractions(localClient);
      },
    );
  });
}
