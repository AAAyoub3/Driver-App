import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/modules/auth/data/models/requests/apply_request.dart';
import 'package:flowery/modules/auth/domain/entities/apply_response_entity.dart';
import 'package:flowery/modules/auth/domain/entities/country_entity.dart';
import 'package:flowery/modules/auth/domain/entities/driver_entity.dart';
import 'package:flowery/modules/auth/domain/entities/vehicle_entity.dart';
import 'package:flowery/modules/auth/presentation/screens/apply_screen.dart';
import 'package:flowery/modules/auth/presentation/view_model/cubit/apply_cubit.dart';
import 'package:flowery/modules/auth/presentation/view_model/events/apply_events.dart';
import 'package:flowery/modules/auth/presentation/view_model/state/apply_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

class MockApplyCubit extends MockCubit<ApplyState> implements ApplyCubit {}

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

const _applySuccess = ApplyResponseEntity(
  message: 'success',
  driver: DriverEntity(
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
  ),
  token: 'token',
);

ApplyState _loadedState() {
  return const ApplyState(
    selectedCountry: _country,
    selectedVehicle: _vehicle,
    countriesState: BaseState.success([_country]),
    vehiclesState: BaseState.success([_vehicle]),
  );
}

Widget createScreen({
  required ApplyCubit cubit,
  List<NavigatorObserver> navigatorObservers = const [],
}) {
  return ScreenUtilInit(
    designSize: const Size(375, 812),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        theme: ThemeData(useMaterial3: true),
        navigatorObservers: navigatorObservers,
        routes: {
          AppRoutes.applySuccess: (_) =>
              const Scaffold(body: Text('apply-success-route')),
          AppRoutes.login: (_) => const Scaffold(body: Text('login-route')),
        },
        home: BlocProvider<ApplyCubit>.value(
          value: cubit,
          child: const ApplyScreen(),
        ),
      );
    },
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const imagePickerChannel = MethodChannel('plugins.flutter.io/image_picker');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(imagePickerChannel, (call) async {
          if (call.method == 'pickImage') {
            return {'path': '/tmp/test-image.png'};
          }
          return null;
        });

    registerFallbackValue(
      ApplyEvent(
        application: ApplyRequest(
          firstName: 'Ahmed',
          lastName: 'Ali',
          email: 'ahmed@example.com',
          phone: '+11234567890',
          password: 'Ahmed@123',
          repassword: 'Ahmed@123',
          gender: 'male',
          country: 'United States',
          vehicleType: '1',
          vehicleNumber: 'abc123',
          vehicleLicense: XFile('/tmp/license.png'),
          nid: '123456789',
          nidImg: XFile('/tmp/id.png'),
        ),
      ),
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(imagePickerChannel, null);
  });

  group('ApplyScreen widget tests', () {
    testWidgets(
      'renders the initial loading UI while country and vehicle data load',
      (tester) async {
        final cubit = MockApplyCubit();
        when(() => cubit.state).thenReturn(
          const ApplyState(
            countriesState: BaseState.loading(),
            vehiclesState: BaseState.loading(),
          ),
        );

        await tester.pumpWidget(createScreen(cubit: cubit));

        expect(find.text('Apply'), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'renders the form and main content when the cubit state is loaded',
      (tester) async {
        final cubit = MockApplyCubit();
        when(() => cubit.state).thenReturn(_loadedState());

        await tester.pumpWidget(createScreen(cubit: cubit));
        await tester.pumpAndSettle();

        expect(find.text('Welcome!!'), findsOneWidget);
        expect(
          find.text('You want to be a delivery man?\nJoin our team!'),
          findsOneWidget,
        );
        expect(find.text('Country'), findsOneWidget);
        expect(find.text('Vehicle Type'), findsOneWidget);
        expect(find.text('Continue'), findsOneWidget);
        expect(find.byType(TextFormField), findsWidgets);
      },
    );

    testWidgets(
      'shows form validation errors when the submit button is pressed with empty values',
      (tester) async {
        final cubit = MockApplyCubit();
        when(() => cubit.state).thenReturn(_loadedState());

        await tester.pumpWidget(createScreen(cubit: cubit));
        await tester.pumpAndSettle();

        await tester.ensureVisible(find.byType(ElevatedButton));
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        expect(find.text('Please enter your first legal name'), findsOneWidget);
        expect(
          find.text('Please enter your second legal name'),
          findsOneWidget,
        );
        expect(find.text('Please enter your phone number'), findsOneWidget);
        expect(find.text('Please enter your email'), findsOneWidget);
        expect(find.text('Please confirm your password'), findsOneWidget);
        expect(find.text('Please enter your ID number'), findsOneWidget);
        expect(find.text('Please enter your vehicle number'), findsOneWidget);
      },
    );

    testWidgets(
      'submits a valid application and triggers the apply event on the cubit',
      (tester) async {
        final cubit = MockApplyCubit();
        when(() => cubit.state).thenReturn(_loadedState());
        when(() => cubit.doEvent(any())).thenAnswer((_) {});

        await tester.pumpWidget(createScreen(cubit: cubit));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextFormField).at(0), 'Ahmed');
        await tester.enterText(find.byType(TextFormField).at(1), 'Ali');
        await tester.enterText(find.byType(TextFormField).at(2), '01123456789');
        await tester.enterText(
          find.byType(TextFormField).at(3),
          'ahmed@example.com',
        );
        await tester.enterText(find.byType(TextFormField).at(4), 'Ahmed@123');
        await tester.enterText(find.byType(TextFormField).at(5), 'Ahmed@123');
        await tester.enterText(find.byType(TextFormField).at(6), '123456789');
        await tester.enterText(find.byType(TextFormField).at(7), '1234567890');

        await tester.ensureVisible(find.byType(GestureDetector).at(0));
        await tester.tap(find.byType(GestureDetector).at(0));
        await tester.pumpAndSettle();
        await tester.ensureVisible(find.byType(GestureDetector).at(1));
        await tester.tap(find.byType(GestureDetector).at(1));
        await tester.pumpAndSettle();

        await tester.ensureVisible(find.byType(ElevatedButton));
        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        verify(() => cubit.doEvent(any())).called(1);
      },
    );

    testWidgets(
      'shows the loading label on the submit button while the apply state is loading',
      (tester) async {
        final cubit = MockApplyCubit();
        when(() => cubit.state).thenReturn(
          _loadedState().copyWith(applyState: const BaseState.loading()),
        );

        await tester.pumpWidget(createScreen(cubit: cubit));
        await tester.pump();

        expect(find.byType(CircularProgressIndicator), findsWidgets);
      },
    );

    testWidgets(
      'reflects the success state by navigating to the success route',
      (tester) async {
        final cubit = MockApplyCubit();
        final states = StreamController<ApplyState>();
        whenListen(cubit, states.stream, initialState: _loadedState());

        await tester.pumpWidget(createScreen(cubit: cubit));
        states.add(
          _loadedState().copyWith(applyState: BaseState.success(_applySuccess)),
        );
        await tester.pump();
        await tester.pumpAndSettle();

        expect(find.text('apply-success-route'), findsOneWidget);
      },
    );
  });
}
