import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/modules/auth/presentation/screens/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:mocktail/mocktail.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late MockNavigatorObserver mockObserver;

  setUp(() {
    mockObserver = MockNavigatorObserver();
  });

  Future<void> pumpOnBoardingScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            routes: {
              AppRoutes.login: (context) => const Scaffold(body: Text('Login Screen')),
              AppRoutes.apply: (context) => const Scaffold(body: Text('Apply Screen')),
            },
            home: const OnBoardingScreen(),
            navigatorObservers: [mockObserver],
          );
        },
      ),
    );
  }

  group('OnBoardingScreen Widget Tests', () {
    testWidgets('renders all core UI elements successfully', (WidgetTester tester) async {
      await pumpOnBoardingScreen(tester);

      // Verify Lottie animation asset is present
      expect(find.byType(Lottie), findsOneWidget);

      // Verify text elements using localized keys (assuming English fallback)
      expect(find.text('Welcome to'), findsOneWidget);
      expect(find.text('Flowery Rider App'), findsOneWidget);

      // Verify buttons are rendered
      expect(find.byType(ElevatedButton), findsNWidgets(2));
      expect(find.widgetWithText(ElevatedButton,'Login'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton,'Apply'), findsOneWidget);
    });

    testWidgets('tapping Login button navigates to AppRoutes.login route', (WidgetTester tester) async {
      await pumpOnBoardingScreen(tester);

      // Tap the Login elevated button
      await tester.tap(find.widgetWithText(ElevatedButton,"Login"));
      await tester.pumpAndSettle();

      // Verify navigation occurred to login route
      expect(find.text('Login Screen'), findsOneWidget);
    });

    testWidgets('tapping Apply button navigates to AppRoutes.apply route', (WidgetTester tester) async {
      await pumpOnBoardingScreen(tester);

      // Tap the CustomButton for apply
      await tester.tap(find.widgetWithText(ElevatedButton,"Apply"));
      await tester.pumpAndSettle();

      // Verify navigation occurred to apply route
      expect(find.text('Apply Screen'), findsOneWidget);
    });
  });
}