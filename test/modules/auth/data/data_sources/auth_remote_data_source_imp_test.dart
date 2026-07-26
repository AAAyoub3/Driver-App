import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/auth/api/api_client/auth_api_client.dart';
import 'package:flowery/modules/auth/api/data_source/auth_remote_data_source_imp.dart';
import 'package:flowery/modules/auth/data/models/request/login_request_model.dart';
import 'package:flowery/modules/auth/data/models/response/login_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_remote_data_source_imp_test.mocks.dart';

@GenerateMocks([AuthApiClient])
void main() {
  late MockAuthApiClient mockApiClient;
  late AuthRemoteDataSourceImp dataSource;

  const request = LoginRequestModel(
    email: 'test@test.com',
    password: 'Test@1234',
  );

  setUpAll(() {
    provideDummy<LoginResponse>(LoginResponse());
  });

  setUp(() {
    mockApiClient = MockAuthApiClient();
    dataSource = AuthRemoteDataSourceImp(mockApiClient);
  });

  group('AuthRemoteDataSourceImp login', () {
    test('returns success with data when api call works', () async {
      when(mockApiClient.login(request)).thenAnswer(
        (_) async => LoginResponse(message: 'success', token: 'token123'),
      );

      final result = await dataSource.login(request);

      expect(result, isA<Success<LoginResponse>>());
      expect((result as Success<LoginResponse>).data?.token, 'token123');
      expect(result.data?.message, 'success');
    });

    test('returns error when api throws DioException', () async {
      when(mockApiClient.login(request)).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.connectionError,
        ),
      );

      final result = await dataSource.login(request);

      expect(result, isA<Error<LoginResponse>>());
    });

    test('returns error when api throws generic exception', () async {
      when(mockApiClient.login(request))
          .thenThrow(Exception('something went wrong'));

      final result = await dataSource.login(request);

      expect(result, isA<Error<LoginResponse>>());
    });
  });
}
