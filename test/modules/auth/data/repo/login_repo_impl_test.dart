import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/auth/data/data_sources/auth_remote_data_source_contract.dart';
import 'package:flowery/modules/auth/data/models/request/login_request_model.dart';
import 'package:flowery/modules/auth/data/models/response/login_response_model.dart';
import 'package:flowery/modules/auth/data/repo/auth_repo_imp.dart';
import 'package:flowery/modules/auth/domain/entity/login_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_repo_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSourceContract])
void main() {
  late MockAuthRemoteDataSourceContract mockDataSource;
  late LoginRepoImpl repo;

  const request = LoginRequestModel(
    email: 'test@test.com',
    password: 'Test@1234',
  );

  setUpAll(() {
    provideDummy<Result<LoginResponse>>(const Error());
  });

  setUp(() {
    mockDataSource = MockAuthRemoteDataSourceContract();
    repo = LoginRepoImpl(mockDataSource);
  });

  group('LoginRepoImpl login', () {
    test('returns LoginEntity when data source succeeds', () async {
      when(mockDataSource.login(request)).thenAnswer(
        (_) async => Success(
          data: LoginResponse(message: 'Login successfully', token: 'token123'),
        ),
      );

      final result = await repo.login(request);

      expect(result, isA<Success<LoginEntity>>());
      expect((result as Success<LoginEntity>).data?.token, 'token123');
      expect(result.data?.message, 'Login successfully');
    });

    test('returns error when data source returns error', () async {
      when(mockDataSource.login(request)).thenAnswer(
        (_) async => Error(exception: Exception('Unauthorized')),
      );

      final result = await repo.login(request);

      expect(result, isA<Error<LoginEntity>>());
      expect((result as Error<LoginEntity>).exception.toString(),
          contains('Unauthorized'));
    });

    test('maps token correctly from response to entity', () async {
      when(mockDataSource.login(request)).thenAnswer(
        (_) async => Success(
          data: LoginResponse(message: 'ok', token: 'abc123'),
        ),
      );

      final result = await repo.login(request);
      final entity = (result as Success<LoginEntity>).data!;

      expect(entity.token, 'abc123');
    });
  });
}
