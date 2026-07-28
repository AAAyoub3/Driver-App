import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/modules/auth/presentation/screens/apply_successful.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

Widget createScreen({List<NavigatorObserver> navigatorObservers = const []}) {
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
        home: const ApplySuccessful(),
        routes: {
          AppRoutes.login: (_) => const Scaffold(body: Text('login-route')),
        },
      );
    },
  );
}

void main() {
  group('ApplySuccessful widget tests', () {
    testWidgets('renders the success screen with all essential content', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(createScreen());
      await tester.pumpAndSettle();

      expect(find.text('Your application has been submitted'), findsOneWidget);
      expect(
        find.text(
          'Thank you for providing your application. We will review your application and get back to you soon.',
        ),
        findsOneWidget,
      );
      expect(find.widgetWithText(ElevatedButton, 'Log In'), findsOneWidget);
    });

    testWidgets('navigates to login when the CTA button is tapped', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final observer = MockNavigatorObserver();

      await tester.pumpWidget(createScreen(navigatorObservers: [observer]));
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'Log In'));
      await tester.tap(find.widgetWithText(ElevatedButton, 'Log In'));
      await tester.pumpAndSettle();

      expect(find.text('login-route'), findsOneWidget);
    });
  });
}
