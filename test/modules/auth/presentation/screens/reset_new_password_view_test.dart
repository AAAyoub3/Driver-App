import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/core/widgets/custom_button.dart';
import 'package:flowery/modules/auth/data/models/requestes/reset_password_request.dart';
import 'package:flowery/modules/auth/data/models/responses/reset_password_response.dart';
import 'package:flowery/modules/auth/presentation/screens/reset_new_password_view.dart';
import 'package:flowery/modules/auth/presentation/view_models/cubit/forget_password_view_model.dart';
import 'package:flowery/modules/auth/presentation/view_models/events/forget_password_evente.dart';
import 'package:flowery/modules/auth/presentation/view_models/states/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockForgetPasswordViewModel extends MockCubit<ForgetPasswordState>
    implements ForgetPasswordViewModel {}

void main() {
  late MockForgetPasswordViewModel mockCubit;

  setUpAll(() {
    registerFallbackValue(ForgetPasswordState.initial());
    registerFallbackValue(
      ResetPasswordEvent(
        request: ResetPasswordRequest(email: '', password: ''),
      ),
    );
  });

  setUp(() {
    mockCubit = MockForgetPasswordViewModel();

    when(() => mockCubit.state).thenReturn(ForgetPasswordState.initial());
    when(() => mockCubit.close()).thenAnswer((_) async {});
    when(
      () => mockCubit.doIntent(event: any(named: 'event')),
    ).thenAnswer((_) async {});
  });

  Future<AppLocalizations> pumpView(
    WidgetTester tester, {
    ForgetPasswordState? initialState,
    Stream<ForgetPasswordState>? stateStream,
  }) async {
    whenListen(
      mockCubit,
      stateStream ?? const Stream<ForgetPasswordState>.empty(),
      initialState: initialState ?? ForgetPasswordState.initial(),
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
            AppRoutes.login: (_) =>
                const Scaffold(body: Text('Login Screen')),
          },
          home: Builder(
            builder: (context) {
              l10n = AppLocalizations.of(context)!;
              return BlocProvider<ForgetPasswordViewModel>.value(
                value: mockCubit,
                child: const ResetNewPasswordView(),
              );
            },
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    return l10n;
  }

  group('ResetNewPasswordView', () {
    testWidgets(
      'renders title, subtitle, two password fields and confirm button',
      (tester) async {
        final l10n = await pumpView(tester);

        expect(find.text(l10n.reset_password), findsOneWidget);
        expect(find.text(l10n.password_must_not_be_empty), findsOneWidget);
        expect(find.byType(TextFormField), findsNWidgets(2));
        expect(find.byType(CustomButton), findsOneWidget);
      },
    );

    testWidgets(
      'shows validation errors and does not call doIntent when fields are empty',
      (tester) async {
        await pumpView(tester);

        await tester.tap(find.byType(CustomButton), warnIfMissed: false);
        await tester.pumpAndSettle();

        expect(find.text('Password is required'), findsNWidgets(2));
        verifyNever(() => mockCubit.doIntent(event: any(named: 'event')));
      },
    );

    testWidgets(
      'shows validation error for invalid password format',
      (tester) async {
        await pumpView(tester);

        final fields = find.byType(TextFormField);
        await tester.enterText(fields.at(0), '123');
        await tester.enterText(fields.at(1), '123');

        await tester.tap(find.byType(CustomButton), warnIfMissed: false);
        await tester.pumpAndSettle();

        expect(find.text('Invalid password'), findsWidgets);
        verifyNever(() => mockCubit.doIntent(event: any(named: 'event')));
      },
    );

    testWidgets(
      'calls doIntent with ResetPasswordEvent using state.email when passwords are valid',
      (tester) async {
        await pumpView(
          tester,
          initialState: ForgetPasswordState.initial().copyWith(
            email: 'test@example.com',
          ),
        );

        final fields = find.byType(TextFormField);
        await tester.enterText(fields.at(0), 'StrongPass123!');
        await tester.enterText(fields.at(1), 'StrongPass123!');

        await tester.tap(find.byType(CustomButton), warnIfMissed: false);
        await tester.pumpAndSettle();

        final captured = verify(
          () => mockCubit.doIntent(event: captureAny(named: 'event')),
        ).captured;

        expect(captured.single, isA<ResetPasswordEvent>());
        final event = captured.single as ResetPasswordEvent;
        expect(event.request.email, 'test@example.com');
        expect(event.request.password, 'StrongPass123!');
      },
    );

    testWidgets(
      'disables button while resetPasswordState is loading',
      (tester) async {
        final controller = StreamController<ForgetPasswordState>();
        addTearDown(controller.close);

        await pumpView(tester, stateStream: controller.stream);

        final loadingState = ForgetPasswordState.initial().copyWith(
          resetPasswordState: const BaseState<ResetPasswordResponse>.loading(),
        );
        when(() => mockCubit.state).thenReturn(loadingState);
        controller.add(loadingState);
        await tester.pumpAndSettle();

        final fields = find.byType(TextFormField);
        await tester.enterText(fields.at(0), 'StrongPass123!');
        await tester.enterText(fields.at(1), 'StrongPass123!');

        await tester.tap(find.byType(CustomButton), warnIfMissed: false);
        await tester.pumpAndSettle();

        verifyNever(() => mockCubit.doIntent(event: any(named: 'event')));
      },
    );

    testWidgets(
      'navigates to login and clears stack when resetPasswordState becomes success',
      (tester) async {
        final controller = StreamController<ForgetPasswordState>();
        addTearDown(controller.close);

        await pumpView(tester, stateStream: controller.stream);

        final successState = ForgetPasswordState.initial().copyWith(
          resetPasswordState: BaseState<ResetPasswordResponse>.success(
            ResetPasswordResponse(),
          ),
        );
        when(() => mockCubit.state).thenReturn(successState);
        controller.add(successState);
        await tester.pumpAndSettle();

        expect(find.text('Login Screen'), findsOneWidget);
      },
    );

    testWidgets(
      'shows SnackBar when resetPasswordState becomes error',
      (tester) async {
        final controller = StreamController<ForgetPasswordState>();
        addTearDown(controller.close);

        await pumpView(tester, stateStream: controller.stream);

        final errorState = ForgetPasswordState.initial().copyWith(
          resetPasswordState: BaseState<ResetPasswordResponse>.error(
            Exception('Reset failed'),
          ),
        );
        when(() => mockCubit.state).thenReturn(errorState);
        controller.add(errorState);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.textContaining('Reset failed'), findsOneWidget);
      },
    );
  });
}