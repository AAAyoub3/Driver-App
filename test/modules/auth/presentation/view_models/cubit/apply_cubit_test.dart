import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/modules/auth/data/models/requests/apply_request.dart';
import 'package:flowery/modules/auth/domain/entities/apply_response_entity.dart';
import 'package:flowery/modules/auth/domain/entities/country_entity.dart';
import 'package:flowery/modules/auth/domain/entities/driver_entity.dart';
import 'package:flowery/modules/auth/domain/entities/vehicle_entity.dart';
import 'package:flowery/modules/auth/domain/use_cases/apply_use_case.dart';
import 'package:flowery/modules/auth/domain/use_cases/get_countries_use_case.dart';
import 'package:flowery/modules/auth/domain/use_cases/get_vehicles_use_case.dart';
import 'package:flowery/modules/auth/presentation/view_model/cubit/apply_cubit.dart';
import 'package:flowery/modules/auth/presentation/view_model/events/apply_events.dart';
import 'package:flowery/modules/auth/presentation/view_model/state/apply_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCountriesUseCase extends Mock implements GetCountriesUseCase {}

class MockGetVehiclesUseCase extends Mock implements GetVehiclesUseCase {}

class MockApplyUseCase extends Mock implements ApplyUseCase {}

const _country = CountryEntity(
  isoCode: 'US',
  name: 'United States',
  phoneCode: '1',
  flag: '🇺🇸',
  currency: 'USD',
  latitude: '0',
  longitude: '0',
  timezones: [],
);

const _vehicle = VehicleEntity(id: '1', type: 'Sedan');

const _driver = DriverEntity(
  country: 'United States',
  firstName: 'Ahmed',
  lastName: 'Ali',
  vehicleType: '1',
  vehicleNumber: 'ABC123',
  vehicleLicense: 'license',
  nid: '1234',
  nidImg: 'id',
  email: 'ahmed@example.com',
  gender: 'male',
  phone: '+11234567890',
  photo: null,
  role: 'driver',
  id: 'driver-1',
  createdAt: null,
);

const _applyResponse = ApplyResponseEntity(
  message: 'success',
  driver: _driver,
  token: 'token',
);

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
  late MockGetCountriesUseCase getCountriesUseCase;
  late MockGetVehiclesUseCase getVehiclesUseCase;
  late MockApplyUseCase applyUseCase;

  setUp(() {
    getCountriesUseCase = MockGetCountriesUseCase();
    getVehiclesUseCase = MockGetVehiclesUseCase();
    applyUseCase = MockApplyUseCase();
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

  tearDown(() {
    getCountriesUseCase = MockGetCountriesUseCase();
    getVehiclesUseCase = MockGetVehiclesUseCase();
    applyUseCase = MockApplyUseCase();
  });

  group('ApplyCubit tests', () {
    test('should have the initial state when created', () {
      final cubit = ApplyCubit(
        getCountriesUseCase,
        applyUseCase,
        getVehiclesUseCase,
      );

      expect(cubit.state, const ApplyState());
    });

    blocTest<ApplyCubit, ApplyState>(
      'emits loading then success when get countries succeeds',
      build: () =>
          ApplyCubit(getCountriesUseCase, applyUseCase, getVehiclesUseCase),
      setUp: () {
        when(() => getCountriesUseCase.call()).thenAnswer(
          (_) async => const Success<List<CountryEntity>>(data: [_country]),
        );
      },
      act: (cubit) => cubit.doEvent(GetCountriesEvent()),
      expect: () => [
        const ApplyState(countriesState: BaseState.loading()),
        const ApplyState(countriesState: BaseState.success([_country])),
      ],
      verify: (_) {
        verify(() => getCountriesUseCase.call()).called(1);
      },
    );

    blocTest<ApplyCubit, ApplyState>(
      'emits loading then error when get countries fails',
      build: () =>
          ApplyCubit(getCountriesUseCase, applyUseCase, getVehiclesUseCase),
      setUp: () {
        when(() => getCountriesUseCase.call()).thenAnswer(
          (_) async => Error<List<CountryEntity>>(exception: Exception('boom')),
        );
      },
      act: (cubit) => cubit.doEvent(GetCountriesEvent()),
      expect: () => [
        isA<ApplyState>().having(
          (state) => state.countriesState.state,
          'countriesState.state',
          StateType.loading,
        ),
        isA<ApplyState>().having(
          (state) => state.countriesState.state,
          'countriesState.state',
          StateType.error,
        ),
      ],
      verify: (_) {
        verify(() => getCountriesUseCase.call()).called(1);
      },
    );

    blocTest<ApplyCubit, ApplyState>(
      'emits loading then success when get vehicles succeeds',
      build: () =>
          ApplyCubit(getCountriesUseCase, applyUseCase, getVehiclesUseCase),
      setUp: () {
        when(() => getVehiclesUseCase.call()).thenAnswer(
          (_) async => const Success<List<VehicleEntity>>(data: [_vehicle]),
        );
      },
      act: (cubit) => cubit.doEvent(GetVehiclesEvent()),
      expect: () => [
        const ApplyState(vehiclesState: BaseState.loading()),
        const ApplyState(vehiclesState: BaseState.success([_vehicle])),
      ],
      verify: (_) {
        verify(() => getVehiclesUseCase.call()).called(1);
      },
    );

    blocTest<ApplyCubit, ApplyState>(
      'emits loading then error when get vehicles fails',
      build: () =>
          ApplyCubit(getCountriesUseCase, applyUseCase, getVehiclesUseCase),
      setUp: () {
        when(() => getVehiclesUseCase.call()).thenAnswer(
          (_) async => Error<List<VehicleEntity>>(exception: Exception('boom')),
        );
      },
      act: (cubit) => cubit.doEvent(GetVehiclesEvent()),
      expect: () => [
        isA<ApplyState>().having(
          (state) => state.vehiclesState.state,
          'vehiclesState.state',
          StateType.loading,
        ),
        isA<ApplyState>().having(
          (state) => state.vehiclesState.state,
          'vehiclesState.state',
          StateType.error,
        ),
      ],
      verify: (_) {
        verify(() => getVehiclesUseCase.call()).called(1);
      },
    );

    test(
      'updates the selected country and vehicle values when events are fired',
      () {
        final cubit = ApplyCubit(
          getCountriesUseCase,
          applyUseCase,
          getVehiclesUseCase,
        );

        cubit.doEvent(SelectCountryEvent(selectedCountry: _country));
        cubit.doEvent(SelectVehicleEvent(selectedVehicle: _vehicle));
        cubit.doEvent(SelectGenderEvent(selectedGender: 'female'));
        cubit.doEvent(
          UploadLicenseEvent(uploadedLicense: XFile('/tmp/license.png')),
        );
        cubit.doEvent(UploadIDEvent(uploadedID: XFile('/tmp/id.png')));

        expect(cubit.state.selectedCountry, _country);
        expect(cubit.state.selectedVehicle, _vehicle);
        expect(cubit.state.selectedGender, 'female');
        expect(cubit.state.uploadedLicense?.path, '/tmp/license.png');
        expect(cubit.state.uploadedID?.path, '/tmp/id.png');
      },
    );

    blocTest<ApplyCubit, ApplyState>(
      'applies a valid request and emits loading then success',
      build: () =>
          ApplyCubit(getCountriesUseCase, applyUseCase, getVehiclesUseCase),
      setUp: () {
        when(() => applyUseCase.call(any())).thenAnswer(
          (_) async => const Success<ApplyResponseEntity>(data: _applyResponse),
        );
      },
      act: (cubit) async {
        final request = await _createRequest();
        cubit.doEvent(ApplyEvent(application: request));
      },
      expect: () => [
        const ApplyState(applyState: BaseState.loading()),
        const ApplyState(applyState: BaseState.success(_applyResponse)),
      ],
      verify: (_) {
        verify(() => applyUseCase.call(any())).called(1);
      },
    );

    blocTest<ApplyCubit, ApplyState>(
      'applies a request and emits loading then error when the use case fails',
      build: () =>
          ApplyCubit(getCountriesUseCase, applyUseCase, getVehiclesUseCase),
      setUp: () {
        final exception = Exception('apply failed');
        when(() => applyUseCase.call(any())).thenAnswer(
          (_) async => Error<ApplyResponseEntity>(exception: exception),
        );
      },
      act: (cubit) async {
        final request = await _createRequest();
        cubit.doEvent(ApplyEvent(application: request));
      },
      expect: () => [
        const ApplyState(applyState: BaseState.loading()),
        isA<ApplyState>().having(
          (state) => state.applyState.state,
          'applyState.state',
          StateType.error,
        ),
      ],
      verify: (_) {
        verify(() => applyUseCase.call(any())).called(1);
      },
    );

    test('does not call use cases when no event is dispatched', () {
      verifyNever(() => getCountriesUseCase.call());
      verifyNever(() => getVehiclesUseCase.call());
      verifyNever(() => applyUseCase.call(any()));
    });
  });
}
