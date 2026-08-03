import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/modules/auth/domain/entity/login_entity.dart';
import 'package:flowery/modules/auth/domain/repo_contract/login_repo_contract.dart';
import 'package:flowery/modules/auth/domain/use_case/login_use_case.dart';
import 'package:flowery/modules/auth/presentation/view_model/cubit.dart';
import 'package:flowery/modules/auth/presentation/view_model/event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_cubit_test.mocks.dart';

@GenerateMocks([LoginRepoContract])
void main() {
  late MockLoginRepoContract mockRepo;
  late LoginCubit cubit;

  const fakeEntity = LoginEntity(
    message: 'Login successfully',
    token: 'fake_token_123',
  );

  setUpAll(() {
    provideDummy<Result<LoginEntity>>(const Error());
  });

  setUp(() {
    mockRepo = MockLoginRepoContract();
    cubit = LoginCubit(LoginUseCase(mockRepo));
  });

  tearDown(() => cubit.close());

  group('LoginCubit', () {
    test('initial state is initial', () {
      expect(cubit.state.loginState.state, StateType.initial);
    });

    test('emits loading then success when login succeeds', () async {
      when(mockRepo.login(any, rememberMe: anyNamed('rememberMe')))
          .thenAnswer((_) async => const Success(data: fakeEntity));

      final states = <StateType>[];
      cubit.stream.listen((s) => states.add(s.loginState.state!));

      cubit.doEvent(LoginEvent(email: 'test@test.com', password: 'Test@1234'));
      await Future.delayed(Duration.zero);

      expect(states, [StateType.loading, StateType.success]);
      expect(cubit.state.loginState.data?.token, 'fake_token_123');
    });

    test('emits loading then error when login fails', () async {
      when(mockRepo.login(any, rememberMe: anyNamed('rememberMe'))).thenAnswer(
        (_) async => Error(exception: Exception('Invalid credentials')),
      );

      final states = <StateType>[];
      cubit.stream.listen((s) => states.add(s.loginState.state!));

      cubit.doEvent(LoginEvent(email: 'wrong@test.com', password: 'wrong'));
      await Future.delayed(Duration.zero);

      expect(states, [StateType.loading, StateType.error]);
      expect(cubit.state.loginState.exception, isNotNull);
    });
  });
}
