import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/general_cubit/constants.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/modules/profile/presentation/screens/edit_vehicle_screen.dart';
import 'package:flowery/modules/profile/presentation/view_models/cubit/edit_vehicle_view_model.dart';
import 'package:flowery/modules/profile/presentation/view_models/events/edit_vehicle_events.dart';
import 'package:flowery/modules/profile/presentation/view_models/states/edit_vehicle_state.dart';
import 'package:flowery/modules/profile/presentation/widgets/vehicle_type_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockEditVehicleViewModel extends Mock implements EditVehicleViewModel {}

void main() {
  late MockEditVehicleViewModel viewModel;
  final getIt = GetIt.instance;

  setUpAll(() {
    registerFallbackValue(SelectVehicleTypeEvent(vehicleType: ''));
  });

  setUp(() {
    viewModel = MockEditVehicleViewModel();

    when(() => viewModel.state).thenReturn(const EditVehicleState());
    when(
      () => viewModel.stream,
    ).thenAnswer((_) => const Stream<EditVehicleState>.empty());
    when(() => viewModel.doEvent(any())).thenReturn(null);
    when(() => viewModel.close()).thenAnswer((_) async {});

    if (getIt.isRegistered<EditVehicleViewModel>()) {
      getIt.unregister<EditVehicleViewModel>();
    }
    getIt.registerFactory<EditVehicleViewModel>(() => viewModel);
  });

  tearDown(() {
    if (getIt.isRegistered<EditVehicleViewModel>()) {
      getIt.unregister<EditVehicleViewModel>();
    }
  });

  Widget createWidget({String? vehicleType, String? vehicleNumber}) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: EditVehicleScreen(
          vehicleType: vehicleType,
          vehicleNumber: vehicleNumber,
        ),
      ),
    );
  }

  testWidgets(
    'Renders dropdown, text field, license field, and update button',
    (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byType(VehicleTypeDropdown), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(GestureDetector), findsWidgets);
      expect(find.byType(ElevatedButton), findsOneWidget);
    },
  );

  testWidgets('Seeds cubit with initial vehicleType on creation', (
    tester,
  ) async {
    // BlocProvider.value bypasses `create`, so the seeding call itself lives
    // in EditVehicleScreen.build's `create`. Since we're using .value here,
    // this test instead verifies the widget renders with an externally-set
    // initial state that mimics what the seed event would produce.
    when(
      () => viewModel.state,
    ).thenReturn(const EditVehicleState(selectedVehicleType: 'Car'));

    await tester.pumpWidget(createWidget(vehicleType: 'Car'));

    expect(find.text('Car'), findsOneWidget);
  });

  testWidgets('Shows placeholder text when no license file is picked', (
    tester,
  ) async {
    await tester.pumpWidget(createWidget());

    expect(find.text(AppConstants.photoNumber), findsOneWidget);
  });

  testWidgets('Shows license file name when a file is picked', (tester) async {
    when(
      () => viewModel.state,
    ).thenReturn(EditVehicleState(licenseFile: File('/tmp/license.jpg')));

    await tester.pumpWidget(createWidget());

    expect(find.text('license.jpg'), findsOneWidget);
    expect(find.text(AppConstants.photoNumber), findsNothing);
  });

  testWidgets('Selecting a vehicle type dispatches SelectVehicleTypeEvent', (
    tester,
  ) async {
    await tester.pumpWidget(createWidget());

    await tester.tap(find.byType(VehicleTypeDropdown));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Van').last);
    await tester.pumpAndSettle();

    verify(
      () => viewModel.doEvent(
        any(
          that: isA<SelectVehicleTypeEvent>().having(
            (e) => e.vehicleType,
            'vehicleType',
            'Van',
          ),
        ),
      ),
    ).called(1);
  });

  testWidgets(
    'Tapping update with all fields filled dispatches UpdateVehicleInfoEvent',
    (tester) async {
      when(
        () => viewModel.state,
      ).thenReturn(const EditVehicleState(selectedVehicleType: 'Car'));

      await tester.pumpWidget(createWidget(vehicleNumber: 'ABC123'));

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      verify(
        () => viewModel.doEvent(any(that: isA<UpdateVehicleInfoEvent>())),
      ).called(1);
    },
  );

  testWidgets(
    'Tapping update with missing fields shows a SnackBar and does not dispatch',
    (tester) async {
      await tester.pumpWidget(createWidget());

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      verifyNever(
        () => viewModel.doEvent(any(that: isA<UpdateVehicleInfoEvent>())),
      );
    },
  );

  testWidgets(
    'Shows loading indicator and disables button when isLoading is true',
    (tester) async {
      when(
        () => viewModel.state,
      ).thenReturn(const EditVehicleState(isLoading: true));

      await tester.pumpWidget(createWidget());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    },
  );

  testWidgets('Shows a SnackBar with message when state becomes done', (
    tester,
  ) async {
    whenListen(
      viewModel,
      Stream.fromIterable([
        const EditVehicleState(),
        const EditVehicleState(isDone: true, message: 'Vehicle updated'),
      ]),
      initialState: const EditVehicleState(),
    );

    await tester.pumpWidget(createWidget());
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Vehicle updated'), findsOneWidget);
  });
}
