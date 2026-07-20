import 'dart:async';

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
import 'package:flowery/modules/auth/presentation/view_models/events/forget_password_evente.dart';
import 'package:flowery/modules/auth/presentation/view_models/states/forget_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';




@injectable
class ForgetPasswordViewModel extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase _sendEmailUseCase;
  final VerifyEmailUseCase _verifyEmailUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  Timer? _timer;

  ForgetPasswordViewModel(
      this._sendEmailUseCase,
      this._verifyEmailUseCase,
      this._resetPasswordUseCase,
      ) : super(ForgetPasswordState.initial());

  Future<void> doIntent({
    required ForgetPasswordEvent event,
  }) async {
    switch (event) {
      case SendEmailEvent():
        await _sendEmail(event.request);

      case VerifyEmailEvent():
        await _verifyEmail(event.request);

      case ResetPasswordEvent():
        await _resetPassword(event);

      case UpdateOtpEvent():
        await _updateOtp(event.otp);
    }
  }

  void _startTimerOTP() {
    _timer?.cancel();

    emit(
      state.copyWith(
        isResendEnabled: false,
        timerValue: 60,
      ),
    );

    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        if (isClosed) {
          _timer?.cancel();
          return;
        }

        if (state.timerValue == 0) {
          _timer?.cancel();

          emit(
            state.copyWith(
              isResendEnabled: true,
            ),
          );
        } else {
          emit(
            state.copyWith(
              timerValue: state.timerValue - 1,
            ),
          );
        }
      },
    );
  }

  Future<void> _updateOtp(String otp) async {
    emit(state.copyWith(otpValue: otp, hasError: false));
    if (otp.length == 6) {
      await _verifyEmail(VerifyResetPasswordRequest(resetCode: otp));
    }
  }

  Future<void> _sendEmail(
      ForgetPasswordRequest request,
      ) async {
    emit(
      state.copyWith(
        forgetPasswordState:
        const BaseState<ForgetPasswordResponse>.loading(),
      ),
    );

    final response =
    await _sendEmailUseCase.forgetPassword(request);

    switch (response) {
      case Success<ForgetPasswordResponse>():
        emit(
          state.copyWith(
            email: request.email,
            forgetPasswordState:
            BaseState<ForgetPasswordResponse>.success(
              response.data,
            ),
          ),
        );

        _startTimerOTP();


      case Error<ForgetPasswordResponse>():
        emit(
          state.copyWith(
            forgetPasswordState:
            BaseState<ForgetPasswordResponse>.error(
              Exception(response.exception),
            ),
          ),
        );
    }
  }

  Future<void> _verifyEmail(VerifyResetPasswordRequest request) async {
    emit(
      state.copyWith(
        hasError: false, // ✅ نمسح الخطأ عند كل محاولة
        verifyEmailState: const BaseState<VerifyEmailResponse>.loading(),
      ),
    );

    final response = await _verifyEmailUseCase.verifyEmail(request);

    switch (response) {
      case Success<VerifyEmailResponse>():
        emit(
          state.copyWith(
            verifyEmailState: BaseState<VerifyEmailResponse>.success(response.data),
          ),
        );

      case Error<VerifyEmailResponse>():
        emit(
          state.copyWith(
            hasError: true,
            otpValue: '',
            otpResetKey: state.otpResetKey + 1,
            verifyEmailState: BaseState<VerifyEmailResponse>.error(
              Exception(response.exception),
            ),
          ),
        );
    }
  }

  Future<void> _resetPassword(
      ResetPasswordEvent event,
      ) async {
    final savedEmail = state.email;

    if (savedEmail == null) return;

    emit(
      state.copyWith(
        resetPasswordState:
        const BaseState<ResetPasswordResponse>.loading(),
      ),
    );

    final response =
    await _resetPasswordUseCase.resetPassword(
      ResetPasswordRequest(
        email: savedEmail,
        password: event.request.password,
      ),
    );

    switch (response) {
      case Success<ResetPasswordResponse>():
        emit(
          state.copyWith(
            resetPasswordState:
            BaseState<ResetPasswordResponse>.success(
              response.data,
            ),
          ),
        );

      case Error<ResetPasswordResponse>():
        emit(
          state.copyWith(
            resetPasswordState:
            BaseState<ResetPasswordResponse>.error(
              Exception(response.exception),
            ),
          ),
        );
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}