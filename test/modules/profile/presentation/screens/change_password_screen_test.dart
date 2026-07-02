import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/widgets/custom_text_form_field.dart';
import 'package:flowery/modules/profile/presentation/keys/change_password_screen_keys.dart';
import 'package:flowery/modules/profile/presentation/screens/change_password_screen.dart';
import 'package:flowery/modules/profile/presentation/view_models/cubit/change_password_view_model.dart';
import 'package:flowery/modules/profile/presentation/view_models/states/change_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

class MockChangePasswordViewModel extends Mock
    implements ChangePasswordViewModel {}

void main() {
  late MockChangePasswordViewModel viewModel;

  setUp(() {
    viewModel = MockChangePasswordViewModel();

    when(() => viewModel.state).thenReturn(const ChangePasswordState());
    when(
      () => viewModel.stream,
    ).thenAnswer((_) => const Stream<ChangePasswordState>.empty());
  });

  Widget createWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: BlocProvider<ChangePasswordViewModel>.value(
        value: viewModel,
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const ChangePasswordScreen(),
        ),
      ),
    );
  }

  testWidgets('Render fields and update button', (tester) async {
    await tester.pumpWidget(createWidget());

    expect(find.byType(CustomTextFormField), findsNWidgets(3));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('Show validation messages when fields are empty', (tester) async {
    await tester.pumpWidget(createWidget());

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('Enter current password'), findsOneWidget);
    expect(find.text('Enter new password'), findsOneWidget);
    expect(find.text('Enter confirm password'), findsOneWidget);
  });

  testWidgets('Show Snackbar message when fields are filled', (tester) async {
        whenListen(
      viewModel,
      Stream.fromIterable([
        const ChangePasswordState(),
        const ChangePasswordState(isDone: true),
      ]),
      initialState: const ChangePasswordState(),
    );
    await tester.pumpWidget(createWidget());

    await tester.enterText(
      find.byKey(Key(ChangePasswordScreenKeys.currentPassword)),
      "123qweASD@",
    );
    await tester.enterText(
      find.byKey(Key(ChangePasswordScreenKeys.newPassword)),
      "qwe123ASD@",
    );
    await tester.enterText(
      find.byKey(Key(ChangePasswordScreenKeys.confirmPassword)),
      "qwe123ASD@",
    );

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.byType(SnackBar), findsOneWidget);
  });

  testWidgets('Write the current password with correct regex', (tester) async {
    await tester.pumpWidget(createWidget());

    await tester.enterText(
      find.byKey(Key(ChangePasswordScreenKeys.currentPassword)),
      "123qweASD@",
    );
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('This password is not valid'), findsNothing);
  });

  testWidgets('Write the current password with incorrect regex', (
    tester,
  ) async {
    await tester.pumpWidget(createWidget());

    await tester.enterText(
      find.byKey(Key(ChangePasswordScreenKeys.currentPassword)),
      "123qweASD",
    );
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('This password is not valid'), findsOneWidget);
  });

  testWidgets('Write the new password with correct regex', (tester) async {
    await tester.pumpWidget(createWidget());

    await tester.enterText(
      find.byKey(Key(ChangePasswordScreenKeys.newPassword)),
      "123qweASD@",
    );
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('This password is not valid'), findsNothing);
  });

  testWidgets('Write the new password with incorrect regex', (tester) async {
    await tester.pumpWidget(createWidget());

    await tester.enterText(
      find.byKey(Key(ChangePasswordScreenKeys.newPassword)),
      "123qweASD",
    );
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('This password is not valid'), findsOneWidget);
  });

  testWidgets('Write the confirm password mismatch with the new password', (
    tester,
  ) async {
    await tester.pumpWidget(createWidget());

    await tester.enterText(
      find.byKey(Key(ChangePasswordScreenKeys.newPassword)),
      "123qweASD@",
    );
    await tester.enterText(
      find.byKey(Key(ChangePasswordScreenKeys.confirmPassword)),
      "123qweASD",
    );
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(
      find.text('Password and confirm password must be same!'),
      findsOneWidget,
    );
  });
}
