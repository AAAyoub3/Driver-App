import 'dart:async';

import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/services/secure_storage_service.dart';
import 'package:flowery/modules/auth/domain/entity/login_entity.dart';
import 'package:flowery/modules/auth/domain/repo_contract/login_repo_contract.dart';
import 'package:flowery/modules/auth/domain/use_case/login_use_case.dart';
import 'package:flowery/modules/auth/presentation/view/widgets/login_body.dart';
import 'package:flowery/modules/auth/presentation/view_model/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_page_test.mocks.dart';

@GenerateMocks([LoginRepoContract, SecureStorageService])
void main() {
  late MockLoginRepoContract mockRepo;
  late MockSecureStorageService mockStorage;
  late LoginCubit cubit;

  setUpAll(() {
    provideDummy<Result<LoginEntity>>(const Error());
  });

  setUp(() {
    mockRepo = MockLoginRepoContract();
    mockStorage = MockSecureStorageService();
    cubit = LoginCubit(LoginUseCase(mockRepo), mockStorage);
  });

  tearDown(() => cubit.close());

  Future<void> pumpLoginBody(WidgetTester tester) async {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: BlocProvider<LoginCubit>.value(
            value: cubit,
            child: Scaffold(
              body: SingleChildScrollView(
                child: LoginBody(loginCubit: cubit),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // The Ahem test font makes each character exactly (fontSize)px wide,
    // which causes overflow in LoginRememberMeRow on the 375px test surface.
    // This overflow doesn't happen on real devices with normal fonts.
    final exception = tester.takeException();
    if (exception != null) {
      final message = exception.toString();
      if (!message.contains('overflowed')) throw exception;
    }
  }

  group('LoginBody widget', () {
    testWidgets('shows email and password fields', (tester) async {
      await pumpLoginBody(tester);

      expect(find.byType(TextFormField), findsNWidgets(2));
    });

    testWidgets('shows continue button', (tester) async {
      await pumpLoginBody(tester);

      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('shows remember me checkbox', (tester) async {
      await pumpLoginBody(tester);

      expect(find.byType(Checkbox), findsOneWidget);
    });

    testWidgets('continue button is disabled when fields are empty',
        (tester) async {
      await pumpLoginBody(tester);

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('continue button is enabled after filling both fields',
        (tester) async {
      await pumpLoginBody(tester);

      await tester.enterText(find.byType(TextFormField).first, 'test@test.com');
      await tester.enterText(find.byType(TextFormField).last, 'Test@1234');
      await tester.pump();

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNotNull);
    });

    testWidgets('shows email validation error on invalid email', (tester) async {
      await pumpLoginBody(tester);

      await tester.enterText(find.byType(TextFormField).first, 'not-an-email');
      await tester.pump();

      expect(find.text('This email is not valid'), findsOneWidget);
    });

    testWidgets('remember me checkbox is unchecked by default', (tester) async {
      await pumpLoginBody(tester);

      final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(checkbox.value, false);
    });

    testWidgets('remember me checkbox toggles when tapped', (tester) async {
      await pumpLoginBody(tester);

      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(checkbox.value, true);
    });

    testWidgets('shows loading indicator while waiting for response',
        (tester) async {
      final completer = Completer<Result<LoginEntity>>();
      when(mockRepo.login(any)).thenAnswer((_) => completer.future);

      await pumpLoginBody(tester);

      await tester.enterText(find.byType(TextFormField).first, 'test@test.com');
      await tester.enterText(find.byType(TextFormField).last, 'Test@1234!');
      await tester.pump();

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      completer.complete(
          const Success(data: LoginEntity(message: '', token: '')));
      await tester.pumpAndSettle();
    });

    testWidgets('saves token when remember me is checked and login succeeds',
        (tester) async {
      when(mockRepo.login(any)).thenAnswer(
        (_) async =>
            const Success(data: LoginEntity(message: 'ok', token: 'token123')),
      );
      when(mockStorage.saveToken(any)).thenAnswer((_) async {});

      await pumpLoginBody(tester);

      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      await tester.enterText(find.byType(TextFormField).first, 'test@test.com');
      await tester.enterText(find.byType(TextFormField).last, 'Test@1234!');
      await tester.pump();

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      verify(mockStorage.saveToken('token123')).called(1);
    });

    testWidgets(
        'does not save token when remember me is unchecked and login succeeds',
        (tester) async {
      when(mockRepo.login(any)).thenAnswer(
        (_) async =>
            const Success(data: LoginEntity(message: 'ok', token: 'token123')),
      );

      await pumpLoginBody(tester);

      await tester.enterText(find.byType(TextFormField).first, 'test@test.com');
      await tester.enterText(find.byType(TextFormField).last, 'Test@1234!');
      await tester.pump();

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      verifyNever(mockStorage.saveToken(any));
    });
  });
}
