import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/profile/domain/entities/my_profile_entity.dart';
import 'package:flowery/modules/profile/domain/use_cases/get_my_profile_data_use_case.dart';
import 'package:flowery/modules/profile/presentation/view_models/cubit/my_profiel_view_model.dart';
import 'package:flowery/modules/profile/presentation/view_models/events/my_profile_event.dart';
import 'package:flowery/modules/profile/presentation/view_models/states/get_profile_data_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetMyProfileDataUseCase extends Mock
    implements GetMyProfileDataUseCase {}

void main() {
  late MockGetMyProfileDataUseCase mockUseCase;
  late MyProfielViewModel viewModel;

  final tProfileEntity = MyProfileEntity(fullName: '', email: '', phone: '', photo: '', vehicleType: '', vehicleNumber: '');

  final tException = Exception('Something went wrong');

  setUpAll(() {
    // Needed by mocktail if MyProfileEntity is ever used with `any()`.
    registerFallbackValue(tProfileEntity);
  });

  setUp(() {
    mockUseCase = MockGetMyProfileDataUseCase();
    viewModel = MyProfielViewModel(mockUseCase);
  });

  tearDown(() {
    viewModel.close();
  });

  test('initial state has isLoadingData true, no data, no error', () {
    expect(viewModel.state.isLoadingData, true);
    expect(viewModel.state.data, isNull);
    expect(viewModel.state.errorMessage, isNull);
  });

  group('doEvent -> GetMyprofileData', () {
    blocTest<MyProfielViewModel, GetProfileDataState>(
      'emits state with isLoadingData=false and data set when use case succeeds',
      build: () {
        when(() => mockUseCase.call()).thenAnswer(
          (_) async => Success<MyProfileEntity>(data: tProfileEntity),
        );
        return viewModel;
      },
      act: (cubit) => cubit.doEvent(GetMyprofileData()),
      expect: () => [
        predicate<GetProfileDataState>(
          (state) =>
              state.isLoadingData == false &&
              state.data == tProfileEntity &&
              state.errorMessage == null,
        ),
      ],
      verify: (_) {
        verify(() => mockUseCase.call()).called(1);
      },
    );

    blocTest<MyProfielViewModel, GetProfileDataState>(
      'emits state with isLoadingData=false and errorMessage set when use case fails',
      build: () {
        when(() => mockUseCase.call()).thenAnswer(
          (_) async => Error<MyProfileEntity>(exception: tException),
        );
        return viewModel;
      },
      act: (cubit) => cubit.doEvent(GetMyprofileData()),
      expect: () => [
        predicate<GetProfileDataState>(
          (state) =>
              state.isLoadingData == false &&
              state.data == null &&
              state.errorMessage == tException.toString(),
        ),
      ],
      verify: (_) {
        verify(() => mockUseCase.call()).called(1);
      },
    );

    blocTest<MyProfielViewModel, GetProfileDataState>(
      'calls the use case exactly once per event',
      build: () {
        when(() => mockUseCase.call()).thenAnswer(
          (_) async => Success<MyProfileEntity>(data: tProfileEntity),
        );
        return viewModel;
      },
      act: (cubit) => cubit.doEvent(GetMyprofileData()),
      verify: (_) {
        verify(() => mockUseCase.call()).called(1);
        verifyNoMoreInteractions(mockUseCase);
      },
    );
  });
}