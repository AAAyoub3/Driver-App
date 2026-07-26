import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/modules/auth/data/models/requestes/forget_password_request.dart';
import 'package:flowery/modules/auth/data/models/requestes/reset_password_request.dart';
import 'package:flowery/modules/auth/data/models/requestes/verify_reset_password_request.dart';
import 'package:flowery/modules/auth/data/models/responses/forget_password_response.dart';
import 'package:flowery/modules/auth/data/models/responses/reset_password_response.dart';
import 'package:flowery/modules/auth/data/models/responses/verify_email_response.dart';
import 'package:flowery/modules/auth/domain/use_cases/forget_password_use_case.dart';
import 'package:flowery/modules/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:flowery/modules/auth/domain/use_cases/verify_email_use_case.dart';
import 'package:flowery/modules/auth/presentation/view_models/cubit/forget_password_view_model.dart';
import 'package:flowery/modules/auth/presentation/view_models/events/forget_password_evente.dart';
import 'package:flowery/modules/auth/presentation/view_models/states/forget_password_state.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// ---------------------------------------------------------------------------
// Mocks
// ---------------------------------------------------------------------------
class MockForgetPasswordUseCase extends Mock implements ForgetPasswordUseCase {}

class MockVerifyEmailUseCase extends Mock implements VerifyEmailUseCase {}

class MockResetPasswordUseCase extends Mock implements ResetPasswordUseCase {}

// ---------------------------------------------------------------------------
// Fallbacks  (mocktail requires registerFallbackValue for custom types)
// ---------------------------------------------------------------------------
class FakeForgetPasswordRequest extends Fake implements ForgetPasswordRequest {}

class FakeVerifyResetPassword extends Fake
    implements VerifyResetPasswordRequest {}

class FakeResetPasswordRequest extends Fake implements ResetPasswordRequest {}

// ---------------------------------------------------------------------------
// Shared test data
// ---------------------------------------------------------------------------
const _testEmail = 'test@flowery.com';
const _testOtp = '123456';
const _testPassword = 'NewPass123!';

final _sendRequest = ForgetPasswordRequest(email: _testEmail);
final _verifyRequest = VerifyResetPasswordRequest(resetCode: _testOtp);
final _resetRequest = ResetPasswordRequest(password: _testPassword);

final _serverError = Exception('Server error');

// ---------------------------------------------------------------------------
// Matchers — read state fields, no Equatable needed on ForgetPasswordState
// ---------------------------------------------------------------------------
TypeMatcher<ForgetPasswordState> _hasForgetState(StateType type) =>
    isA<ForgetPasswordState>().having(
      (s) => s.forgetPasswordState.state,
      'forgetPasswordState.stateType',
      type,
    );

TypeMatcher<ForgetPasswordState> _hasVerifyState(StateType type) =>
    isA<ForgetPasswordState>().having(
      (s) => s.verifyEmailState.state,
      'verifyEmailState.stateType',
      type,
    );

TypeMatcher<ForgetPasswordState> _hasResetState(StateType type) =>
    isA<ForgetPasswordState>().having(
      (s) => s.resetPasswordState.state,
      'resetPasswordState.stateType',
      type,
    );

void main() {
  late MockForgetPasswordUseCase mockSendUC;
  late MockVerifyEmailUseCase mockVerifyUC;
  late MockResetPasswordUseCase mockResetUC;

  setUpAll(() {
    registerFallbackValue(FakeForgetPasswordRequest());
    registerFallbackValue(FakeVerifyResetPassword());
    registerFallbackValue(FakeResetPasswordRequest());
  });

  setUp(() {
    mockSendUC = MockForgetPasswordUseCase();
    mockVerifyUC = MockVerifyEmailUseCase();
    mockResetUC = MockResetPasswordUseCase();
  });

  ForgetPasswordViewModel buildCubit() =>
      ForgetPasswordViewModel(mockSendUC, mockVerifyUC, mockResetUC);

  // ── 1. Initial state ───────────────────────────────────────────────────────
  group('initial state', () {
    test('has correct defaults', () {
      final cubit = buildCubit();

      expect(cubit.state.email, isNull);
      expect(cubit.state.timerValue, 0);
      expect(cubit.state.isResendEnabled, true);
      expect(cubit.state.hasError, false);
      expect(cubit.state.otpValue, '');
      expect(cubit.state.otpResetKey, 0);
      expect(cubit.state.forgetPasswordState.state, StateType.initial);
      expect(cubit.state.verifyEmailState.state, StateType.initial);
      expect(cubit.state.resetPasswordState.state, StateType.initial);

      cubit.close();
    });
  });

  // ── 2. SendEmailEvent ──────────────────────────────────────────────────────
  group('SendEmailEvent', () {
    blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
      'emits [loading, success] and saves email when use case succeeds',
      build: () {
        when(() => mockSendUC.forgetPassword(any())).thenAnswer(
          (_) async => Success(data: ForgetPasswordResponse(message: 'Sent')),
        );
        return buildCubit();
      },
      act: (c) => c.doIntent(event: SendEmailEvent(request: _sendRequest)),
      expect: () => [
        _hasForgetState(StateType.loading),
        // success state + email saved
        isA<ForgetPasswordState>()
            .having(
              (s) => s.forgetPasswordState.state,
              'success',
              StateType.success,
            )
            .having((s) => s.email, 'email saved', _testEmail),
        // timer started immediately after success
        isA<ForgetPasswordState>()
            .having((s) => s.isResendEnabled, 'resend disabled', false)
            .having((s) => s.timerValue, 'timer at 60', 60),
      ],
      verify: (_) => verify(() => mockSendUC.forgetPassword(any())).called(1),
    );

    blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
      'emits [loading, error] when use case fails',
      build: () {
        when(
          () => mockSendUC.forgetPassword(any()),
        ).thenAnswer((_) async => Error(exception: _serverError));
        return buildCubit();
      },
      act: (c) => c.doIntent(event: SendEmailEvent(request: _sendRequest)),
      expect: () => [
        _hasForgetState(StateType.loading),
        _hasForgetState(StateType.error),
      ],
    );

    blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
      'does NOT save email when use case fails',
      build: () {
        when(
          () => mockSendUC.forgetPassword(any()),
        ).thenAnswer((_) async => Error(exception: _serverError));
        return buildCubit();
      },
      act: (c) => c.doIntent(event: SendEmailEvent(request: _sendRequest)),
      verify: (c) => expect(c.state.email, isNull),
    );

    blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
      'does NOT start timer when use case fails',
      build: () {
        when(
          () => mockSendUC.forgetPassword(any()),
        ).thenAnswer((_) async => Error(exception: _serverError));
        return buildCubit();
      },
      act: (c) => c.doIntent(event: SendEmailEvent(request: _sendRequest)),
      verify: (c) {
        expect(c.state.isResendEnabled, true);
        expect(c.state.timerValue, 0);
      },
    );
  });

  // ── 3. VerifyEmailEvent ────────────────────────────────────────────────────
  group('VerifyEmailEvent', () {
    blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
      'emits [clears error + loading, success] when use case succeeds',
      build: () {
        when(() => mockVerifyUC.verifyEmail(any())).thenAnswer(
          (_) async => Success(data: VerifyEmailResponse(status: 'ok')),
        );
        return buildCubit();
      },
      act: (c) => c.doIntent(event: VerifyEmailEvent(request: _verifyRequest)),
      expect: () => [
        // loading emit also clears hasError
        isA<ForgetPasswordState>()
            .having(
              (s) => s.verifyEmailState.state,
              'loading',
              StateType.loading,
            )
            .having((s) => s.hasError, 'error cleared', false),
        _hasVerifyState(StateType.success),
      ],
    );

    blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
      'emits [loading, error] with hasError=true and resets OTP when use case fails',
      build: () {
        when(
          () => mockVerifyUC.verifyEmail(any()),
        ).thenAnswer((_) async => Error(exception: _serverError));
        return buildCubit();
      },
      act: (c) => c.doIntent(event: VerifyEmailEvent(request: _verifyRequest)),
      expect: () => [
        _hasVerifyState(StateType.loading),
        isA<ForgetPasswordState>()
            .having((s) => s.verifyEmailState.state, 'error', StateType.error)
            .having((s) => s.hasError, 'hasError true', true)
            .having((s) => s.otpValue, 'otp cleared', '')
            .having((s) => s.otpResetKey, 'resetKey incremented', 1),
      ],
    );

    blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
      'increments otpResetKey on each consecutive error',
      build: () {
        when(
          () => mockVerifyUC.verifyEmail(any()),
        ).thenAnswer((_) async => Error(exception: _serverError));
        return buildCubit();
      },
      act: (c) async {
        await c.doIntent(event: VerifyEmailEvent(request: _verifyRequest));
        await c.doIntent(event: VerifyEmailEvent(request: _verifyRequest));
      },
      verify: (c) => expect(c.state.otpResetKey, 2),
    );
  });

  // ── 4. ResetPasswordEvent ──────────────────────────────────────────────────
  group('ResetPasswordEvent', () {
    // State seeded with email so _resetPassword doesn't short-circuit.
    ForgetPasswordState stateWithEmail() =>
        ForgetPasswordState.initial().copyWith(
          email: _testEmail,
          forgetPasswordState: BaseState<ForgetPasswordResponse>.success(
            ForgetPasswordResponse(),
          ),
        );

    blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
      'emits [loading, success] when use case succeeds',
      build: () {
        when(() => mockResetUC.resetPassword(any())).thenAnswer(
          (_) async => Success(data: ResetPasswordResponse(message: 'done')),
        );
        return buildCubit();
      },
      seed: stateWithEmail,
      act: (c) => c.doIntent(event: ResetPasswordEvent(request: _resetRequest)),
      expect: () => [
        _hasResetState(StateType.loading),
        _hasResetState(StateType.success),
      ],
    );

    blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
      'emits [loading, error] when use case fails',
      build: () {
        when(
          () => mockResetUC.resetPassword(any()),
        ).thenAnswer((_) async => Error(exception: _serverError));
        return buildCubit();
      },
      seed: stateWithEmail,
      act: (c) => c.doIntent(event: ResetPasswordEvent(request: _resetRequest)),
      expect: () => [
        _hasResetState(StateType.loading),
        _hasResetState(StateType.error),
      ],
    );

    blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
      'emits NOTHING when state.email is null (silent guard)',
      build: buildCubit,
      // No seed → initial state has email = null
      act: (c) => c.doIntent(event: ResetPasswordEvent(request: _resetRequest)),
      expect: () => [],
      // Use case must NOT be called
      verify: (_) => verifyNever(() => mockResetUC.resetPassword(any())),
    );

    blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
      'always uses the email from state, ignoring the email in the request model',
      build: () {
        when(
          () => mockResetUC.resetPassword(any()),
        ).thenAnswer((_) async => Success(data: ResetPasswordResponse()));
        return buildCubit();
      },
      seed: stateWithEmail,
      act: (c) => c.doIntent(event: ResetPasswordEvent(request: _resetRequest)),
      verify: (_) {
        // Capture the actual argument passed to the use case
        final captured = verify(
          () => mockResetUC.resetPassword(captureAny()),
        ).captured;
        final passedRequest = captured.first as ResetPasswordRequest;
        expect(passedRequest.email, _testEmail); // from state, not from request
      },
    );
  });

  // ── 5. UpdateOtpEvent ──────────────────────────────────────────────────────
  group('UpdateOtpEvent', () {
    blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
      'updates otpValue and clears hasError when OTP is incomplete',
      build: buildCubit,
      seed: () => ForgetPasswordState.initial().copyWith(hasError: true),
      act: (c) => c.doIntent(event: UpdateOtpEvent(otp: '123')),
      expect: () => [
        isA<ForgetPasswordState>()
            .having((s) => s.otpValue, 'otpValue', '123')
            .having((s) => s.hasError, 'hasError cleared', false),
      ],
      verify: (_) => verifyNever(() => mockVerifyUC.verifyEmail(any())),
    );

    blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
      'automatically calls verifyEmail when OTP reaches 6 digits — success path',
      build: () {
        when(
          () => mockVerifyUC.verifyEmail(any()),
        ).thenAnswer((_) async => Success(data: VerifyEmailResponse()));
        return buildCubit();
      },
      act: (c) => c.doIntent(event: UpdateOtpEvent(otp: _testOtp)),
      expect: () => [
        // 1. otpValue set
        isA<ForgetPasswordState>().having(
          (s) => s.otpValue,
          'otp set',
          _testOtp,
        ),
        // 2. verifyEmail loading
        _hasVerifyState(StateType.loading),
        // 3. verifyEmail success
        _hasVerifyState(StateType.success),
      ],
      verify: (_) => verify(() => mockVerifyUC.verifyEmail(any())).called(1),
    );

    blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
      'automatically calls verifyEmail when OTP reaches 6 digits — error path',
      build: () {
        when(
          () => mockVerifyUC.verifyEmail(any()),
        ).thenAnswer((_) async => Error(exception: _serverError));
        return buildCubit();
      },
      act: (c) => c.doIntent(event: UpdateOtpEvent(otp: _testOtp)),
      expect: () => [
        isA<ForgetPasswordState>().having(
          (s) => s.otpValue,
          'otp set',
          _testOtp,
        ),
        _hasVerifyState(StateType.loading),
        isA<ForgetPasswordState>()
            .having((s) => s.verifyEmailState.state, 'error', StateType.error)
            .having((s) => s.hasError, 'hasError', true)
            .having((s) => s.otpValue, 'otp cleared', '')
            .having((s) => s.otpResetKey, 'key bumped', 1),
      ],
    );

    blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
      'does NOT call verifyEmail when OTP has fewer than 6 digits',
      build: buildCubit,
      act: (c) async {
        for (final partial in ['1', '12', '123', '1234', '12345']) {
          await c.doIntent(event: UpdateOtpEvent(otp: partial));
        }
      },
      verify: (_) => verifyNever(() => mockVerifyUC.verifyEmail(any())),
    );
  });

  // ── 6. Timer behaviour ─────────────────────────────────────────────────────
  group('Timer', () {
    blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
      'disables resend and sets timerValue to 60 immediately after email is sent',
      build: () {
        when(
          () => mockSendUC.forgetPassword(any()),
        ).thenAnswer((_) async => Success(data: ForgetPasswordResponse()));
        return buildCubit();
      },
      act: (c) => c.doIntent(event: SendEmailEvent(request: _sendRequest)),
      verify: (c) {
        expect(c.state.isResendEnabled, false);
        expect(c.state.timerValue, 60);
      },
    );

    test(
      're-triggers timer when resend is tapped (SendEmailEvent again)',
      () async {
        when(
          () => mockSendUC.forgetPassword(any()),
        ).thenAnswer((_) async => Success(data: ForgetPasswordResponse()));

        final cubit = buildCubit();

        // First send
        await cubit.doIntent(event: SendEmailEvent(request: _sendRequest));
        expect(cubit.state.timerValue, 60);
        expect(cubit.state.isResendEnabled, false);

        // Simulate timer reaching 0 by setting resend enabled manually
        // (we don't wait 600 seconds — we trust Timer.periodic works)

        // Second send (resend)
        await cubit.doIntent(event: SendEmailEvent(request: _sendRequest));
        expect(cubit.state.timerValue, 60);
        expect(cubit.state.isResendEnabled, false);

        await cubit.close();
      },
    );

    test('timer is cancelled when cubit is closed', () async {
      when(
        () => mockSendUC.forgetPassword(any()),
      ).thenAnswer((_) async => Success(data: ForgetPasswordResponse()));

      final cubit = buildCubit();
      await cubit.doIntent(event: SendEmailEvent(request: _sendRequest));

      // close() cancels the timer; no exception should be thrown
      await expectLater(cubit.close(), completes);
    });
  });
}
