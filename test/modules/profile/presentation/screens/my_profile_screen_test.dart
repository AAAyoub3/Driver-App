

import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/modules/profile/domain/entities/my_profile_entity.dart';
import 'package:flowery/modules/profile/presentation/screens/my_profile_screen.dart'; // adjust path if different
import 'package:flowery/modules/profile/presentation/view_models/cubit/my_profiel_view_model.dart';
import 'package:flowery/modules/profile/presentation/view_models/events/my_profile_event.dart';
import 'package:flowery/modules/profile/presentation/view_models/states/get_profile_data_state.dart';
import 'package:flowery/modules/profile/presentation/widgets/personal_info_card.dart';
import 'package:flowery/modules/profile/presentation/widgets/settings_tile.dart';
import 'package:flowery/modules/profile/presentation/widgets/vehicle_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockMyProfielViewModel extends MockCubit<GetProfileDataState>
    implements MyProfielViewModel {}

void main() {
  late MockMyProfielViewModel mockViewModel;

  const tEntity = MyProfileEntity(
    fullName: 'Noor Hossam',
    email: 'noor@example.com',
    phone: '01000000000',
    photo: 'https://example.com/photo.jpg',
    vehicleType: 'Sedan',
    vehicleNumber: 'ABC-1234',
  );

  setUpAll(() {
    registerFallbackValue(GetMyprofileData());
  });

  setUp(() {
    mockViewModel = MockMyProfielViewModel();
    // The screen calls this in initState — stub it so it doesn't throw.
    when(() => mockViewModel.doEvent(any())).thenReturn(null);
  });

  Widget buildTestable() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<MyProfielViewModel>.value(
        value: mockViewModel,
        child: MyProfileScreen(),
      ),
    );
  }

  testWidgets('calls doEvent(GetMyprofileData()) on init', (tester) async {
    whenListen(
      mockViewModel,
      Stream<GetProfileDataState>.empty(),
      initialState: GetProfileDataState(),
    );

    await tester.pumpWidget(buildTestable());

    verify(() => mockViewModel.doEvent(any(that: isA<GetMyprofileData>())))
        .called(1);
  });

  testWidgets('shows a loading indicator while isLoadingData is true',
      (tester) async {
    whenListen(
      mockViewModel,
      Stream<GetProfileDataState>.empty(),
      initialState: GetProfileDataState(),
    );

    await tester.pumpWidget(buildTestable());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(PersonalInfoCard), findsNothing);
  });

  testWidgets('shows the error message when errorMessage is set',
      (tester) async {
    whenListen(
      mockViewModel,
      Stream<GetProfileDataState>.empty(),
      initialState: GetProfileDataState(
        isLoadingData: false,
        errorMessage: 'Something went wrong',
      ),
    );

    await tester.pumpWidget(buildTestable());

    expect(find.text('Something went wrong'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(PersonalInfoCard), findsNothing);
  });

  testWidgets('renders profile content when data is loaded successfully',
      (tester) async {
    whenListen(
      mockViewModel,
      Stream<GetProfileDataState>.empty(),
      initialState: GetProfileDataState(
        isLoadingData: false,
        data: tEntity,
      ),
    );

    // PersonalInfoCard renders a NetworkImage(data.photo). The Flutter test
    // binding always returns HTTP 400 for real network calls, so we mock
    // image loading rather than hitting the network.
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(buildTestable());

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(PersonalInfoCard), findsOneWidget);
      expect(find.byType(VehicleInfoCard), findsOneWidget);
      expect(find.byType(SettingsTile), findsNWidgets(2));

      // PersonalInfoCard content
      expect(find.text(tEntity.fullName), findsOneWidget);
      expect(find.text(tEntity.email), findsOneWidget);
      expect(find.text(tEntity.phone), findsOneWidget);

      // VehicleInfoCard content
      expect(find.text(tEntity.vehicleType), findsOneWidget);
      expect(find.text(tEntity.vehicleNumber), findsOneWidget);

      // Hardcoded logout tile
      expect(find.text('Logout'), findsOneWidget);
    });
  });

  testWidgets('renders nothing extra when data is null and not loading',
      (tester) async {
    whenListen(
      mockViewModel,
      Stream<GetProfileDataState>.empty(),
      initialState: GetProfileDataState(isLoadingData: false),
    );

    await tester.pumpWidget(buildTestable());

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(PersonalInfoCard), findsNothing);
    expect(find.byType(VehicleInfoCard), findsNothing);
  });

  testWidgets('tapping the logout SettingsTile does not throw',
      (tester) async {
    whenListen(
      mockViewModel,
      Stream<GetProfileDataState>.empty(),
      initialState: GetProfileDataState(
        isLoadingData: false,
        data: tEntity,
      ),
    );

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(buildTestable());

      await tester.tap(find.text('Logout'));
      await tester.pumpAndSettle();

 
    });
  });
}