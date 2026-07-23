import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/modules/auth/data/models/responses/forget_password_response.dart';
import 'package:flowery/modules/auth/presentation/screens/forget_password_view.dart';
import 'package:flowery/modules/auth/presentation/view_models/cubit/forget_password_view_model.dart';
import 'package:flowery/modules/auth/presentation/view_models/events/forget_password_evente.dart';
import 'package:flowery/modules/auth/presentation/view_models/states/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockForgetPasswordViewModel extends MockCubit<ForgetPasswordState>
    implements ForgetPasswordViewModel {}
void main() {
  late MockForgetPasswordViewModel mockCubit;

setUpAll(() {
  registerFallbackValue(ForgetPasswordState.initial());
  registerFallbackValue( UpdateOtpEvent(otp: ''));
});

  setUp(() {
    mockCubit = MockForgetPasswordViewModel();

    when(() => mockCubit.state).thenReturn(ForgetPasswordState.initial());
    when(() => mockCubit.close()).thenAnswer((_) async {});
    when(
      () => mockCubit.doIntent(event: any(named: 'event')),
    ).thenAnswer((_) async {});

    if (getIt.isRegistered<ForgetPasswordViewModel>()) {
      getIt.unregister<ForgetPasswordViewModel>();
    }
    getIt.registerFactory<ForgetPasswordViewModel>(() => mockCubit);
  });

  tearDown(() {
    if (getIt.isRegistered<ForgetPasswordViewModel>()) {
      getIt.unregister<ForgetPasswordViewModel>();
    }
  });

  Future<AppLocalizations> pumpView(
    WidgetTester tester, {
    Stream<ForgetPasswordState>? stateStream,
  }) async {
    whenListen(
      mockCubit,
      stateStream ?? const Stream<ForgetPasswordState>.empty(),
      initialState: ForgetPasswordState.initial(),
    );

    late AppLocalizations l10n;

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          routes: {
            AppRoutes.emailVerification: (_) =>
                const Scaffold(body: Text('Email Verification Screen')),
          },
          home: Builder(
            builder: (context) {
              l10n = AppLocalizations.of(context)!;
              return const ForgetPasswordView();
            },
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    return l10n;
  }

  group('ForgetPasswordView', () {
    testWidgets('renders title, subtitle, email field and confirm button', (
      tester,
    ) async {
      final l10n = await pumpView(tester);

      expect(find.text(l10n.forget_password), findsOneWidget);
      expect(
        find.text(l10n.please_enter_your_email_associated_to_your_account),
        findsOneWidget,
      );
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text(l10n.confirm), findsOneWidget);
    });

    testWidgets(
      'shows validation error and does not call doIntent when email is empty',
      (tester) async {
        await pumpView(tester);

        await tester.tap(find.text('Confirm'), warnIfMissed: false);
        await tester.pumpAndSettle();

        expect(find.text('Email is required'), findsOneWidget);
        verifyNever(() => mockCubit.doIntent(event: any(named: 'event')));
      },
    );

    testWidgets(
      'shows validation error for invalid email format',
      (tester) async {
        await pumpView(tester);

        await tester.enterText(find.byType(TextFormField), 'not-an-email');
        await tester.tap(find.text('Confirm'), warnIfMissed: false);
        await tester.pumpAndSettle();

        expect(find.text('Invalid email'), findsOneWidget);
        verifyNever(() => mockCubit.doIntent(event: any(named: 'event')));
      },
    );

    testWidgets(
      'calls doIntent with SendEmailEvent when email is valid',
      (tester) async {
        await pumpView(tester);

        await tester.enterText(
          find.byType(TextFormField),
          'test@example.com',
        );
        await tester.tap(find.text('Confirm'), warnIfMissed: false);
        await tester.pumpAndSettle();

        final captured = verify(
          () => mockCubit.doIntent(event: captureAny(named: 'event')),
        ).captured;

        expect(captured.single, isA<SendEmailEvent>());
        expect(
          (captured.single as SendEmailEvent).request.email,
          'test@example.com',
        );
      },
    );

    testWidgets(
      'disables button and shows loading text when forgetPasswordState is loading',
      (tester) async {
        final controller = StreamController<ForgetPasswordState>();
        addTearDown(controller.close);

        final l10n = await pumpView(tester, stateStream: controller.stream);

        final loadingState = ForgetPasswordState.initial().copyWith(
          forgetPasswordState:
              const BaseState<ForgetPasswordResponse>.loading(),
        );
        when(() => mockCubit.state).thenReturn(loadingState);
        controller.add(loadingState);
        await tester.pumpAndSettle();

        expect(find.text(l10n.loading), findsOneWidget);

        await tester.enterText(
          find.byType(TextFormField),
          'test@example.com',
        );
        await tester.tap(find.text(l10n.loading), warnIfMissed: false);
        await tester.pumpAndSettle();

        verifyNever(() => mockCubit.doIntent(event: any(named: 'event')));
      },
    );

    testWidgets(
      'navigates to emailVerification when forgetPasswordState becomes success',
      (tester) async {
        final controller = StreamController<ForgetPasswordState>();
        addTearDown(controller.close);

        await pumpView(tester, stateStream: controller.stream);

        final successState = ForgetPasswordState.initial().copyWith(
          forgetPasswordState: BaseState<ForgetPasswordResponse>.success(
            ForgetPasswordResponse(),
          ),
        );
        when(() => mockCubit.state).thenReturn(successState);
        controller.add(successState);
        await tester.pumpAndSettle();

        expect(find.text('Email Verification Screen'), findsOneWidget);
      },
    );

    testWidgets(
      'shows SnackBar when forgetPasswordState becomes error',
      (tester) async {
        final controller = StreamController<ForgetPasswordState>();
        addTearDown(controller.close);

        await pumpView(tester, stateStream: controller.stream);

        final errorState = ForgetPasswordState.initial().copyWith(
          forgetPasswordState: BaseState<ForgetPasswordResponse>.error(
            Exception('Something went wrong'),
          ),
        );
        when(() => mockCubit.state).thenReturn(errorState);
        controller.add(errorState);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.textContaining('Something went wrong'), findsOneWidget);
      },
    );
  });
}