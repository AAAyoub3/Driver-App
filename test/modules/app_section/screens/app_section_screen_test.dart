import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/modules/app_section/screens/app_section_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

Widget createTestableWidget(Widget child) {
  return ScreenUtilInit(
    designSize: const Size(375, 812),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, _) {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: child,
      );
    },
  );
}

/// Finds text specifically within the BottomNavigationBar to avoid
/// clashing with matching text in the body (e.g. dummy screens).
Finder findInNavBar(String text) {
  return find.descendant(
    of: find.byType(BottomNavigationBar),
    matching: find.text(text),
  );
}

void main() {
  group('AppSectionScreen', () {
    testWidgets('renders bottom navigation bar with three items', (
      tester,
    ) async {
      await tester.pumpWidget(createTestableWidget(const AppSectionScreen()));
      await tester.pumpAndSettle();

      expect(find.byType(BottomNavigationBar), findsOneWidget);
      expect(findInNavBar('Home'), findsOneWidget);
      expect(findInNavBar('Orders'), findsOneWidget);
      expect(findInNavBar('Profile'), findsOneWidget);
    });

    testWidgets('Home tab is selected by default', (tester) async {
      await tester.pumpWidget(createTestableWidget(const AppSectionScreen()));
      await tester.pumpAndSettle();

      final navBar = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );
      expect(navBar.currentIndex, 0);
    });

    testWidgets('tapping Orders tab updates the selected index', (
      tester,
    ) async {
      await tester.pumpWidget(createTestableWidget(const AppSectionScreen()));
      await tester.pumpAndSettle();

      await tester.tap(findInNavBar('Orders'));
      await tester.pumpAndSettle();

      final navBar = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );
      expect(navBar.currentIndex, 1);
    });

    testWidgets('tapping Profile tab updates the selected index', (
      tester,
    ) async {
      await tester.pumpWidget(createTestableWidget(const AppSectionScreen()));
      await tester.pumpAndSettle();

      await tester.tap(findInNavBar('Profile'));
      await tester.pumpAndSettle();

      final navBar = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );
      expect(navBar.currentIndex, 2);
    });

    testWidgets('tapping Home after switching returns to Home tab', (
      tester,
    ) async {
      await tester.pumpWidget(createTestableWidget(const AppSectionScreen()));
      await tester.pumpAndSettle();

      await tester.tap(findInNavBar('Profile'));
      await tester.pumpAndSettle();
      await tester.tap(findInNavBar('Home'));
      await tester.pumpAndSettle();

      final navBar = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );
      expect(navBar.currentIndex, 0);
    });

    testWidgets('IndexedStack shows correct child after tapping a tab', (
      tester,
    ) async {
      await tester.pumpWidget(createTestableWidget(const AppSectionScreen()));
      await tester.pumpAndSettle();

      await tester.tap(findInNavBar('Orders'));
      await tester.pumpAndSettle();

      final indexedStack = tester.widget<IndexedStack>(
        find.byType(IndexedStack),
      );
      expect(indexedStack.index, 1);
    });
  });
}
