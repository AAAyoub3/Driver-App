import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/profile/data/models/requests/edit_vieckle_request.dart';
import 'package:flowery/modules/profile/data/models/responses/edit_vieckle_response.dart';
import 'package:flowery/modules/profile/domain/use_cases/edit_vieckle_info_use_case.dart';
import 'package:flowery/modules/profile/presentation/view_models/cubit/edit_vehicle_view_model.dart';
import 'package:flowery/modules/profile/presentation/view_models/events/edit_vehicle_events.dart';
import 'package:flowery/modules/profile/presentation/view_models/states/edit_vehicle_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockEditVehicleUseCase extends Mock implements EditVehicleUseCase {}

class FakeEditVehicleRequest extends Fake implements EditVehicleRequest {}

void main() {
  late MockEditVehicleUseCase mockUseCase;
  late EditVehicleRequest testRequest;

  setUpAll(() {
    registerFallbackValue(FakeEditVehicleRequest());
  });

  setUp(() {
    mockUseCase = MockEditVehicleUseCase();
    testRequest = EditVehicleRequest(
      vehicleType: 'Car',
      vehicleNumber: 'ABC123',
      vehicleLicensePath: '/tmp/license.jpg',
      vehicleLicense: '',
    );
  });

  EditVehicleViewModel buildCubit() => EditVehicleViewModel(mockUseCase);

  group('EditVehicleViewModel', () {
    test('initial state is EditVehicleState()', () {
      final cubit = buildCubit();
      expect(cubit.state, const EditVehicleState());
    });

    group('SelectVehicleTypeEvent', () {
      blocTest<EditVehicleViewModel, EditVehicleState>(
        'emits state with updated selectedVehicleType',
        build: buildCubit,
        act: (cubit) => cubit.doEvent(
          SelectVehicleTypeEvent(vehicleType: 'Van'),
        ),
        expect: () => [
          const EditVehicleState().copyWith(selectedVehicleType: 'Van'),
        ],
      );
    });

    group('PickLicenseFileEvent', () {
      blocTest<EditVehicleViewModel, EditVehicleState>(
        'emits state with updated licenseFile',
        build: buildCubit,
        act: (cubit) => cubit.doEvent(
          PickLicenseFileEvent(file: File('/tmp/license.jpg')),
        ),
        expect: () => [
          isA<EditVehicleState>().having(
            (s) => s.licenseFile?.path,
            'licenseFile.path',
            '/tmp/license.jpg',
          ),
        ],
      );
    });

    group('UpdateVehicleInfoEvent', () {
      blocTest<EditVehicleViewModel, EditVehicleState>(
        'emits [loading, done+message] on success',
        setUp: () {
          when(() => mockUseCase.call(request: any(named: 'request')))
              .thenAnswer(
            (_) async => Success<EditVieckleResponse>(
              data: EditVieckleResponse(message: 'Vehicle updated'),
            ),
          );
        },
        build: buildCubit,
        act: (cubit) => cubit.doEvent(
          UpdateVehicleInfoEvent(request: testRequest),
        ),
        expect: () => [
          const EditVehicleState(isLoading: true, isDone: false),
          const EditVehicleState(
            isLoading: false,
            isDone: true,
            message: 'Vehicle updated',
          ),
        ],
        verify: (_) {
          verify(
            () => mockUseCase.call(request: testRequest),
          ).called(1);
        },
      );

      blocTest<EditVehicleViewModel, EditVehicleState>(
        'emits [loading, done+errorMessage] on error',
        setUp: () {
          when(() => mockUseCase.call(request: any(named: 'request')))
              .thenAnswer(
            (_) async => Error<EditVieckleResponse>(
              exception: Exception('Something went wrong'),
            ),
          );
        },
        build: buildCubit,
        act: (cubit) => cubit.doEvent(
          UpdateVehicleInfoEvent(request: testRequest),
        ),
        expect: () => [
          const EditVehicleState(isLoading: true, isDone: false),
          isA<EditVehicleState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.isDone, 'isDone', true)
              .having(
                (s) => s.message,
                'message',
                contains('Something went wrong'),
              ),
        ],
      );
    });
  });
}