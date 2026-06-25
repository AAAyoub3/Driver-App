import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/modules/order_tracking/presentation/screens/order_details_screen.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/cubit/order_details_view_model.dart';
import 'package:flowery/modules/order_tracking/presentation/widgets/custom_address_container.dart';
import 'package:flowery/modules/order_tracking/presentation/widgets/custom_order_container.dart';
import 'package:flowery/modules/order_tracking/presentation/widgets/custom_payment_container.dart';
import 'package:flowery/modules/order_tracking/presentation/widgets/status_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  group('OrderDetailsScreen Widget Tests', () {
    /// Helper function to build the app with BlocProvider

    Widget _buildTestWidget() {
      return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          home: BlocProvider(
            create: (_) => OrderDetailsViewModel(),
            child: const OrderDetailsScreen(),
          ),
        ),
      );
    }

    testWidgets('renders all main widgets correctly', (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(_buildTestWidget());
        await tester.pumpAndSettle();

        expect(find.byType(StatusContainer), findsOneWidget);
        expect(find.byType(CustomAddressContainer), findsNWidgets(2));
        expect(find.byType(CustomOrderContainer), findsOneWidget);
        expect(find.byType(CustomPaymentContainer), findsNWidgets(2));
        expect(find.byType(ElevatedButton), findsOneWidget);
      });
    });

    testWidgets('initial state displays firstState', (
      WidgetTester tester,
    ) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(_buildTestWidget());

        /// Verify the button text shows the first state
        expect(find.text('Arrived at Pickup point'), findsOneWidget);
      });
    });

    testWidgets(
      'transitions from first state to second state when button is pressed',
      (WidgetTester tester) async {
        await mockNetworkImagesFor(() async {
          await tester.pumpWidget(_buildTestWidget());

          /// Verify initial state
          expect(find.text('Arrived at Pickup point'), findsOneWidget);

          /// Tap the button
          await tester.ensureVisible(
            find.byKey(const Key('next_state_button')),
          );
          await tester.tap(find.byKey(const Key('next_state_button')));
          await tester.pump();

          /// Verify state changed to second state
          expect(find.text('Start deliver'), findsOneWidget);
        });
      },
    );

    testWidgets(
      'transitions from first to third state after two button presses',
      (WidgetTester tester) async {
        await mockNetworkImagesFor(() async {
          await tester.pumpWidget(_buildTestWidget());

          /// Press button first time
          await tester.ensureVisible(
            find.byKey(const Key('next_state_button')),
          );
          await tester.tap(find.byKey(const Key('next_state_button')));
          await tester.pump();

          /// Verify second state
          expect(find.text('Start deliver'), findsOneWidget);

          /// Press button second time
          await tester.ensureVisible(
            find.byKey(const Key('next_state_button')),
          );
          await tester.tap(find.byKey(const Key('next_state_button')));
          await tester.pump();

          /// Verify third state
          expect(find.text('Arrived to the user'), findsOneWidget);
        });
      },
    );

    testWidgets(
      'transitions from first to fourth state after three button presses',
      (WidgetTester tester) async {
        await mockNetworkImagesFor(() async {
          await tester.pumpWidget(_buildTestWidget());

          /// Press button three times
          for (int i = 0; i < 3; i++) {
            await tester.ensureVisible(
              find.byKey(const Key('next_state_button')),
            );
            await tester.tap(find.byKey(const Key('next_state_button')));
            await tester.pump();
          }

          /// Verify fourth state
          expect(find.text('Delivered to the user'), findsOneWidget);
        });
      },
    );

    testWidgets('reaches final state (fifth state) after four button presses', (
      WidgetTester tester,
    ) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(_buildTestWidget());

        /// Press button four times
        for (int i = 0; i < 4; i++) {
          await tester.ensureVisible(
            find.byKey(const Key('next_state_button')),
          );
          await tester.tap(find.byKey(const Key('next_state_button')));
          await tester.pump();
        }

        /// Verify fifth state
        expect(find.text('Delivered to the user'), findsOneWidget);
      });
    });

    testWidgets('button is disabled in final state', (
      WidgetTester tester,
    ) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(_buildTestWidget());

        /// Press button four times to reach final state
        for (int i = 0; i < 4; i++) {
          await tester.ensureVisible(
            find.byKey(const Key('next_state_button')),
          );
          await tester.tap(find.byKey(const Key('next_state_button')));
          await tester.pump();
        }

        /// Verify button is disabled (hintGrayColor background)
        final elevatedButton = tester.widget<ElevatedButton>(
          find.byType(ElevatedButton),
        );

        final backgroundColor = elevatedButton.style?.backgroundColor?.resolve(
          {},
        );

        expect(backgroundColor, AppColors.hintGrayColor);

        /// Verify button text still shows the final state
        expect(find.text('Delivered to the user'), findsOneWidget);
      });
    });
  });
}
