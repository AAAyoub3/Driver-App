import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/profile/domain/entities/edit_profile_photo_entity.dart';
import 'package:flowery/modules/profile/domain/use_cases/edit_profile_use_case.dart';
import 'package:flowery/modules/profile/presentation/view_models/cubit/edit_profile_view_model.dart';
import 'package:flowery/modules/profile/presentation/view_models/events/edit_profile_events.dart';
import 'package:flowery/modules/profile/presentation/view_models/states/edit_profile_state.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockEditProfileUseCase extends Mock implements EditProfileUseCase {}

void main() {
  late MockEditProfileUseCase mockUseCase;

  setUpAll(() {
    // Fallback values for mocktail's `any()` matcher on String args.
    registerFallbackValue('');
  });

  setUp(() {
    mockUseCase = MockEditProfileUseCase();
  });

  EditProfileViewModel buildCubit() => EditProfileViewModel(mockUseCase);

  const firstName = 'Noor';
  const lastName = 'Ahmed';
  const email = 'noor@example.com';
  const phoneNumber = '01000000000';

  final updateEvent = UpdateProfileInfoEvent(
    firstName: firstName,
    lastName: lastName,
    email: email,
    phoneNumber: phoneNumber, gender: '',
  );

  group('EditProfileViewModel', () {
    test('initial state is EditProfileState with default values', () {
      final cubit = buildCubit();
      expect(cubit.state.isLoading, false);
      expect(cubit.state.data, isNull);
      expect(cubit.state.errorMessage, isNull);
      expect(cubit.state.gender, isNull);
      cubit.close();
    });

    blocTest<EditProfileViewModel, EditProfileState>(
      'emits state with data when UpdateProfileInfoEvent succeeds',
      build: () {
        when(
          () => mockUseCase.call(any(), any(), any(), any()),
        ).thenAnswer(
          (_) async => Success(data: EditProfileEntity(message: 'Updated')),
        );
        return buildCubit();
      },
      act: (cubit) => cubit.doEvent(updateEvent),
      expect: () => [
        isA<EditProfileState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.data?.message, 'data.message', 'Updated')
            .having((s) => s.errorMessage, 'errorMessage', isNull),
      ],
      verify: (_) {
        verify(
          () => mockUseCase.call(firstName, lastName, email, phoneNumber),
        ).called(1);
      },
    );

    blocTest<EditProfileViewModel, EditProfileState>(
      'emits state with errorMessage when UpdateProfileInfoEvent fails',
      build: () {
        when(
          () => mockUseCase.call(any(), any(), any(), any()),
        ).thenAnswer(
          (_) async => Error(exception: Exception('Something went wrong')),
        );
        return buildCubit();
      },
      act: (cubit) => cubit.doEvent(updateEvent),
      expect: () => [
        isA<EditProfileState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.data, 'data', isNull)
            .having(
              (s) => s.errorMessage,
              'errorMessage',
              contains('Something went wrong'),
            ),
      ],
      verify: (_) {
        verify(
          () => mockUseCase.call(firstName, lastName, email, phoneNumber),
        ).called(1);
      },
    );
  });
}