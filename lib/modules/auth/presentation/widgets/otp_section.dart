import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/modules/auth/data/models/requestes/forget_password_request.dart';
import 'package:flowery/modules/auth/presentation/view_models/cubit/forget_password_view_model.dart';
import 'package:flowery/modules/auth/presentation/view_models/events/forget_password_evente.dart';
import 'package:flowery/modules/auth/presentation/view_models/states/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class OtpSection extends StatelessWidget {
  const OtpSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgetPasswordViewModel, ForgetPasswordState>(
      buildWhen: (prev, curr) =>
      prev.verifyEmailState != curr.verifyEmailState ||
          prev.isResendEnabled != curr.isResendEnabled ||
          prev.timerValue != curr.timerValue ||
          prev.hasError != curr.hasError ||
          prev.otpValue != curr.otpValue ||
          prev.otpResetKey != curr.otpResetKey,
      builder: (context, state) {
        final cubit = context.read<ForgetPasswordViewModel>();
        final l10n = AppLocalizations.of(context)!;
        final isLoading =
            state.verifyEmailState.state == StateType.loading;

        return Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                IgnorePointer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(6, (i) {
                      final char =
                      i < state.otpValue.length ? state.otpValue[i] : '';

                      final isCurrent =
                          i == state.otpValue.length && !isLoading;

                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        width: 40.w,
                        height: 56.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: state.hasError
                                ? Colors.red
                                : isCurrent
                                ? AppColors.primaryColor
                                : AppColors.hintGrayColor,
                            width:
                            isCurrent || state.hasError ? 2 : 1.5,
                          ),
                        ),
                        child: Text(
                          char,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: Opacity(
                    opacity: 0,
                    child: TextField(
                      key: ValueKey(state.otpResetKey),
                      autofocus: true,
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      enabled: !isLoading,
                      onChanged: (value) {
                        cubit.doIntent(
                          event: UpdateOtpEvent(otp: value),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),

            if (state.hasError) ...[
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline,
                      color: Colors.red, size: 16),
                  SizedBox(width: 6.w),
                  Text(
                    l10n.invalid_code,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],

            SizedBox(
              height: 28,
              child: isLoading
                  ? const CircularProgressIndicator(strokeWidth: 2.5)
                  : const SizedBox(),
            ),

            SizedBox(height: 16.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  l10n.didnt_receive_code,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 4.w),
                GestureDetector(
                  onTap: state.isResendEnabled
                      ? () {
                    cubit.doIntent(
                      event: SendEmailEvent(
                        request: ForgetPasswordRequest(
                          email: state.email ?? '',
                        ),
                      ),
                    );
                  }
                      : null,
                  child: Text(
                    l10n.resend,
                    style: TextStyle(
                      color: state.isResendEnabled
                          ? Colors.red
                          : Colors.grey,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),

            if (!state.isResendEnabled) ...[
              SizedBox(height: 8.h),
              Text(
                _formatTimer(state.timerValue),
              ),
            ],
          ],
        );
      },
    );
  }

  String _formatTimer(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }
}