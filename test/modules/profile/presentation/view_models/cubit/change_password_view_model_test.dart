import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/profile/domain/entities/change_password_entity.dart';
import 'package:flowery/modules/profile/domain/use_cases/change_password_use_case.dart';
import 'package:flowery/modules/profile/presentation/view_models/events/change_password_events.dart';
import 'package:flowery/modules/profile/presentation/view_models/cubit/change_password_view_model.dart';
import 'package:flowery/modules/profile/presentation/view_models/states/change_password_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockChangePasswordUseCase extends Mock
    implements ChangePasswordUseCase {}

    void main() {
  late MockChangePasswordUseCase useCase;
  late ChangePasswordViewModel viewModel;

  setUp(() {
    useCase = MockChangePasswordUseCase();
    viewModel = ChangePasswordViewModel(useCase);
  });

  blocTest<ChangePasswordViewModel, ChangePasswordState>(
    'Emits loading then success state when password update succeeds',
    build: () {
      when(
        () => useCase.call(
          any(),
          any(),
        ),
      ).thenAnswer(
        (_) async => Success<ChangePasswordEntity>(
          data: ChangePasswordEntity(
            message: 'Password updated successfully',
          ),
        ),
      );

      return viewModel;
    },
    act: (bloc) => bloc.doEvent(
      UpdatePasswordEvent(
        password: 'oldPass123',
        newPassword: 'newPass123',
      ),
    ),
    expect: () => [
      const ChangePasswordState(
        isLoading: true,
        isDone: false,
      ),
      const ChangePasswordState(
        isLoading: false,
        isDone: true,
        message: 'Password updated successfully',
      ),
    ],
  );
    blocTest<ChangePasswordViewModel, ChangePasswordState>(
    'Emits loading then error state when password update fails',
    build: () {
      when(
        () => useCase.call(
          any(),
          any(),
        ),
      ).thenAnswer(
        (_) async => Error<ChangePasswordEntity>(
          exception: Exception('Invalid password'),
        ),
      );

      return viewModel;
    },
    act: (bloc) => bloc.doEvent(
      UpdatePasswordEvent(
        password: 'wrongPass',
        newPassword: 'newPass123',
      ),
    ),
    expect: () => [
      const ChangePasswordState(
        isLoading: true,
        isDone: false,
      ),
      ChangePasswordState(
        isLoading: false,
        isDone: true,
        message: 'Exception: Invalid password',
      ),
    ],
  );
}