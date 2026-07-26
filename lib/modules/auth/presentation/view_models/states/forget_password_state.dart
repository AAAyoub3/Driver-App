import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/modules/auth/data/models/responses/forget_password_response.dart';
import 'package:flowery/modules/auth/data/models/responses/reset_password_response.dart';
import 'package:flowery/modules/auth/data/models/responses/verify_email_response.dart';


class ForgetPasswordState {
  final String? email;
  final int timerValue;
  final bool isResendEnabled;
  final bool hasError;
  final String otpValue;
  final int otpResetKey;

  final BaseState<ForgetPasswordResponse> forgetPasswordState;
  final BaseState<VerifyEmailResponse> verifyEmailState;
  final BaseState<ResetPasswordResponse> resetPasswordState;

  const ForgetPasswordState({
    this.email,
    this.timerValue = 0,
    this.isResendEnabled = true,
    this.hasError = false,
    this.otpValue = '',
    this.otpResetKey = 0,
    required this.forgetPasswordState,
    required this.verifyEmailState,
    required this.resetPasswordState,
  });

  ForgetPasswordState copyWith({
    String? email,
    int? timerValue,
    bool? isResendEnabled,
    bool? hasError,
    String? otpValue,
    int? otpResetKey,
    BaseState<ForgetPasswordResponse>? forgetPasswordState,
    BaseState<VerifyEmailResponse>? verifyEmailState,
    BaseState<ResetPasswordResponse>? resetPasswordState,
  }) {
    return ForgetPasswordState(
      email: email ?? this.email,
      timerValue: timerValue ?? this.timerValue,
      isResendEnabled: isResendEnabled ?? this.isResendEnabled,
      hasError: hasError ?? this.hasError,
      otpValue: otpValue ?? this.otpValue,
      otpResetKey: otpResetKey ?? this.otpResetKey,
      forgetPasswordState: forgetPasswordState ?? this.forgetPasswordState,
      verifyEmailState: verifyEmailState ?? this.verifyEmailState,
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
    );
  }

  factory ForgetPasswordState.initial() {
    return const ForgetPasswordState(
      email: null,
      timerValue: 0,
      isResendEnabled: true,
      hasError: false,
      otpValue: '',
      otpResetKey: 0,
      forgetPasswordState: BaseState<ForgetPasswordResponse>.initial(),
      verifyEmailState: BaseState<VerifyEmailResponse>.initial(),
      resetPasswordState: BaseState<ResetPasswordResponse>.initial(),
    );
  }
}