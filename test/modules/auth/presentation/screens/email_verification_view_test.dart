import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/modules/auth/data/models/responses/verify_email_response.dart';
import 'package:flowery/modules/auth/presentation/screens/email_verification_view.dart';
import 'package:flowery/modules/auth/presentation/view_models/cubit/forget_password_view_model.dart';
import 'package:flowery/modules/auth/presentation/view_models/states/forget_password_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockForgetPasswordViewModel extends MockCubit<ForgetPasswordState>
    implements ForgetPasswordViewModel {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late MockForgetPasswordViewModel mockCubit;
  late MockNavigatorObserver mockNavigatorObserver;

 setUpAll(() {
    registerFallbackValue(ForgetPasswordState.initial());
  });

  setUp(() {
    mockCubit = MockForgetPasswordViewModel();
    mockNavigatorObserver = MockNavigatorObserver();

    when(() => mockCubit.state).thenReturn(ForgetPasswordState.initial());
    when(() => mockCubit.close()).thenAnswer((_) async {});
  });

  Future<AppLocalizations> pumpView(
    WidgetTester tester, {
    required Stream<ForgetPasswordState> stateStream,
  }) async {
    whenListen(
      mockCubit,
      stateStream,
      initialState: ForgetPasswordState.initial(),
    );

    late AppLocalizations l10n;

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
          navigatorObservers: [mockNavigatorObserver],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          routes: {
            AppRoutes.resetPassword: (_) =>
                const Scaffold(body: Text('Reset Password Screen')),
          },
          home: Builder(
            builder: (context) {
              l10n = AppLocalizations.of(context)!;
              return BlocProvider<ForgetPasswordViewModel>.value(
                value: mockCubit,
                child: const EmailVerificationView(),
              );
            },
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    return l10n;
  }

  group('EmailVerificationView', () {
    testWidgets('renders title, subtitle and OtpSection', (tester) async {
      final l10n = await pumpView(
        tester,
        stateStream: const Stream.empty(),
      );

      expect(find.text(l10n.email_verification), findsOneWidget);
      expect(
        find.text(l10n.please_enter_your_email_associated_to_your_account),
        findsOneWidget,
      );
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets(
      'navigates to resetPassword when verifyEmailState becomes success',
      (tester) async {
        final controller = StreamController<ForgetPasswordState>();
        addTearDown(controller.close);

        await pumpView(tester, stateStream: controller.stream);

        final successState = ForgetPasswordState.initial().copyWith(
          verifyEmailState: BaseState<VerifyEmailResponse>.success(
            VerifyEmailResponse(),
          ),
        );

        when(() => mockCubit.state).thenReturn(successState);
        controller.add(successState);

        await tester.pumpAndSettle();

        expect(find.text('Reset Password Screen'), findsOneWidget);
      },
    );

    testWidgets(
      'shows SnackBar when verifyEmailState becomes error',
      (tester) async {
        final controller = StreamController<ForgetPasswordState>();
        addTearDown(controller.close);

        await pumpView(tester, stateStream: controller.stream);

        final errorState = ForgetPasswordState.initial().copyWith(
          verifyEmailState: BaseState<VerifyEmailResponse>.error(
            Exception('Invalid code'),
          ),
        );

        when(() => mockCubit.state).thenReturn(errorState);
        controller.add(errorState);

        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.textContaining('Invalid code'), findsOneWidget);
      },
    );

    testWidgets(
      'does not navigate or show SnackBar on loading state',
      (tester) async {
        final controller = StreamController<ForgetPasswordState>();
        addTearDown(controller.close);

        await pumpView(tester, stateStream: controller.stream);

        final loadingState = ForgetPasswordState.initial().copyWith(
          verifyEmailState: const BaseState<VerifyEmailResponse>.loading(),
        );

        when(() => mockCubit.state).thenReturn(loadingState);
        controller.add(loadingState);

        await tester.pump();

        expect(find.byType(SnackBar), findsNothing);
        expect(find.text('Reset Password Screen'), findsNothing);
      },
    );
  });
}