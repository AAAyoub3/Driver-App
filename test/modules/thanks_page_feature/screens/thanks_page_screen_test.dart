import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';

import 'package:flowery/modules/thanks_page_feature/screens/thanks_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ThanksPageScreen', () {
    // Helper to pump the screen wrapped with required localization delegates
    Future<void> pumpThanksPageScreen(
      WidgetTester tester, {
      NavigatorObserver? navigatorObserver,
    }) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          navigatorObservers:
              navigatorObserver != null ? [navigatorObserver] : [],
          home: const ThanksPageScreen(),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('renders Scaffold with correct background color',
        (tester) async {
      await pumpThanksPageScreen(tester);

      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffold.backgroundColor, AppColors.whiteColor);
    });

    testWidgets('renders success icon with correct structure',
        (tester) async {
      await pumpThanksPageScreen(tester);

      // 3 stacked circles + 1 check icon
      expect(find.byType(Container), findsNWidgets(3));
      expect(find.byIcon(Icons.check), findsOneWidget);

      final iconWidget = tester.widget<Icon>(find.byIcon(Icons.check));
      expect(iconWidget.color, AppColors.whiteColor);
      expect(iconWidget.size, 32);
    });

    testWidgets('displays localized thank you title with correct style',
        (tester) async {
      await pumpThanksPageScreen(tester);

      final context = tester.element(find.byType(ThanksPageScreen));
      final localizations = AppLocalizations.of(context)!;

      final titleFinder = find.text(localizations.thank_you);
      expect(titleFinder, findsOneWidget);

      final titleWidget = tester.widget<Text>(titleFinder);
      expect(titleWidget.style?.color, AppColors.greenColor);
      expect(titleWidget.style?.fontSize, 20);
      expect(titleWidget.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('displays localized delivery success message',
        (tester) async {
      await pumpThanksPageScreen(tester);

      final context = tester.element(find.byType(ThanksPageScreen));
      final localizations = AppLocalizations.of(context)!;

      final messageFinder =
          find.text(localizations.the_order_delivered_successfully);
      expect(messageFinder, findsOneWidget);

      final messageWidget = tester.widget<Text>(messageFinder);
      expect(messageWidget.textAlign, TextAlign.center);
      expect(messageWidget.style?.color, AppColors.blackColor);
      expect(messageWidget.style?.fontSize, 16);
      expect(messageWidget.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('displays localized Done button with correct style',
        (tester) async {
      await pumpThanksPageScreen(tester);

      final context = tester.element(find.byType(ThanksPageScreen));
      final localizations = AppLocalizations.of(context)!;

      expect(find.text(localizations.done), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);

      final button =
          tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      final style = button.style!;

      expect(
        style.backgroundColor?.resolve({}),
        AppColors.primaryColor,
      );
      expect(style.elevation?.resolve({}), 0);
      expect(style.shape?.resolve({}), isA<StadiumBorder>());
    });

    testWidgets('tapping Done button pops the navigator', (tester) async {
      final mockObserver = _MockNavigatorObserver();

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          navigatorObservers: [mockObserver],
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const ThanksPageScreen(),
                    ),
                  );
                },
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );

      // Navigate to ThanksPageScreen first
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.byType(ThanksPageScreen), findsOneWidget);

      // Tap Done -> should pop back
      final context = tester.element(find.byType(ThanksPageScreen));
      final localizations = AppLocalizations.of(context)!;
      await tester.tap(find.text(localizations.done));
      await tester.pumpAndSettle();

      expect(find.byType(ThanksPageScreen), findsNothing);
      expect(find.text('Open'), findsOneWidget);
    });

    testWidgets('has correct widget structure with Spacers', (tester) async {
      await pumpThanksPageScreen(tester);

      expect(find.byType(Spacer), findsNWidgets(3));
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Padding), findsWidgets);
      expect(find.byType(SafeArea), findsOneWidget);
    });
  });
}

class _MockNavigatorObserver extends NavigatorObserver {}