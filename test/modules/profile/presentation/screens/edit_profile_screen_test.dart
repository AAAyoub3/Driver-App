import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/modules/profile/presentation/screens/edit_profile_screen.dart';
import 'package:flowery/modules/profile/presentation/view_models/cubit/edit_profile_view_model.dart';
import 'package:flowery/modules/profile/presentation/view_models/cubit/uplaod_profile_photo_view_model.dart';
import 'package:flowery/modules/profile/presentation/view_models/events/edit_profile_events.dart';
import 'package:flowery/modules/profile/presentation/view_models/events/upload_profile_photo_event.dart';
import 'package:flowery/modules/profile/presentation/view_models/states/edit_profile_state.dart';
import 'package:flowery/modules/profile/domain/entities/edit_profile_photo_entity.dart';
import 'package:flowery/modules/profile/presentation/view_models/states/upload_profile_photo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// NOTE: import path for EditProfileScreen is assumed based on your project's
// conventions (presentation/screens/edit_profile_screen.dart). Adjust if
// different.
//
// NOTE: assumes `AppLocalizations.localizationsDelegates` and
// `AppLocalizations.supportedLocales` are the generated statics from
// flutter gen-l10n. Adjust if you wire l10n differently in tests.
//
// NOTE: `EditProfileEvents`/`UploadProfilePhotoEvent` are sealed classes, so
// mocktail's any()/captureAny() (which need a registered fallback instance
// of the *exact* declared parameter type) don't play well with them here.
// Instead of mocking the cubits with mocktail, these are small hand-written
// Fake cubits that simply record whatever is passed to doEvent() and let the
// test emit states directly via emitState(). This sidesteps the sealed-type
// fallback-value problem entirely.

class FakeEditProfileViewModel extends Cubit<EditProfileState>
    implements EditProfileViewModel {
  FakeEditProfileViewModel([EditProfileState? initialState])
    : super(initialState ?? EditProfileState());

  final List<EditProfileEvents> capturedEvents = [];

  @override
  void doEvent(EditProfileEvents event) {
    capturedEvents.add(event);
  }

  /// Test-only helper to push a new state through the cubit's stream.
  void emitState(EditProfileState state) => emit(state);
}

class FakeUploadProfilePhotoViewModel extends Cubit<UploadProfilePhotoState>
    implements UplaodProfilePhotoViewModel {
  FakeUploadProfilePhotoViewModel([UploadProfilePhotoState? initialState])
    : super(initialState ?? UploadProfilePhotoState());

  final List<UploadProfilePhotoEvent> capturedEvents = [];

  @override
  void doEvent(UploadProfilePhotoEvent event) {
    capturedEvents.add(event);
  }

  /// Test-only helper to push a new state through the cubit's stream.
  void emitState(UploadProfilePhotoState state) => emit(state);
}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late FakeEditProfileViewModel fakeEditCubit;
  late FakeUploadProfilePhotoViewModel fakeUploadCubit;
  late MockNavigatorObserver mockNavigatorObserver;

  setUpAll(() {
    registerFallbackValue(MaterialPageRoute<void>(builder: (_) => const SizedBox()));
  });

  setUp(() {
    fakeEditCubit = FakeEditProfileViewModel();
    fakeUploadCubit = FakeUploadProfilePhotoViewModel();
    mockNavigatorObserver = MockNavigatorObserver();
  });

  tearDown(() async {
    await fakeEditCubit.close();
    await fakeUploadCubit.close();
  });

  Future<void> pumpScreen(WidgetTester tester) async {
    // Default test surface is 800x600, which is too short for this form —
    // the Update button ends up below the visible area and tap() can't hit
    // it. Give the surface more height so nothing is clipped.
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        navigatorObservers: [mockNavigatorObserver],
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<EditProfileViewModel>.value(value: fakeEditCubit),
            BlocProvider<UplaodProfilePhotoViewModel>.value(
              value: fakeUploadCubit,
            ),
          ],
          child: const EditProfileScreen(
            firstName: 'Noor',
            lastName: 'Ahmed',
            email: 'noor@example.com',
            phone: '01000000000',
            gender: 'male',
            photo: '',
          ),
        ),
      ),
    );
    // NOTE: pumpAndSettle() is intentionally NOT used here — when the state
    // has isLoading: true, CircularProgressIndicator runs an indefinite
    // animation and pumpAndSettle() will time out waiting for it to finish.
    await tester.pump();
  }

  group('EditProfileScreen', () {
    testWidgets('renders initial values from constructor', (tester) async {
      await pumpScreen(tester);

      expect(find.text('Noor'), findsOneWidget);
      expect(find.text('Ahmed'), findsOneWidget);
      expect(find.text('noor@example.com'), findsOneWidget);
      expect(find.text('01000000000'), findsOneWidget);
    });

    testWidgets(
      'shows validation error and does not submit when first name is empty',
      (tester) async {
        await pumpScreen(tester);

        final firstNameField = find.byType(TextFormField).first;
        await tester.enterText(firstNameField, '');
        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        expect(find.text('This field is required'), findsOneWidget);
        expect(
          fakeEditCubit.capturedEvents.whereType<UpdateProfileInfoEvent>(),
          isEmpty,
        );
      },
    );

    testWidgets(
      'dispatches UpdateProfileInfoEvent with form values when valid and tapped',
      (tester) async {
        await pumpScreen(tester);

        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        final updateEvents = fakeEditCubit.capturedEvents
            .whereType<UpdateProfileInfoEvent>();
        expect(updateEvents, hasLength(1));

        final event = updateEvents.first;
        expect(event.firstName, 'Noor');
        expect(event.lastName, 'Ahmed');
        expect(event.email, 'noor@example.com');
        expect(event.phoneNumber, '01000000000');
        expect(event.gender, 'male');
      },
    );

    testWidgets('disables Update button and shows spinner when isLoading is true', (
      tester,
    ) async {
      fakeEditCubit = FakeEditProfileViewModel(EditProfileState(isLoading: true));

      await pumpScreen(tester);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      final button = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );
      expect(button.onPressed, isNull);
    });

    testWidgets('shows SnackBar with error message when EditProfileViewModel emits error', (
      tester,
    ) async {
      await pumpScreen(tester);

      fakeEditCubit.emitState(EditProfileState(errorMessage: 'Update failed'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 750));

      expect(find.text('Update failed'), findsOneWidget);
    });

    testWidgets(
      'shows SnackBar and pops when EditProfileViewModel emits success data',
      (tester) async {
        await pumpScreen(tester);

        fakeEditCubit.emitState(
          EditProfileState(data: EditProfileEntity(message: 'Profile saved')),
        );
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 750));

        expect(find.text('Profile saved'), findsOneWidget);
        verify(() => mockNavigatorObserver.didPop(any(), any())).called(1);
      },
    );

    testWidgets(
      'shows SnackBar with error message when UplaodProfilePhotoViewModel emits error',
      (tester) async {
        await pumpScreen(tester);

        fakeUploadCubit.emitState(
          UploadProfilePhotoState(errorMessage: 'Upload failed'),
        );
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 750));

        expect(find.text('Upload failed'), findsOneWidget);
      },
    );
  });
}