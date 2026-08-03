import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/modules/auth/presentation/view_model/cubit.dart';
import 'package:flowery/modules/auth/presentation/view_model/event.dart';
import 'package:flowery/modules/auth/presentation/view_model/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginContinueButton extends StatelessWidget {
  const LoginContinueButton({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.rememberMe,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool rememberMe;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([emailController, passwordController]),
      builder: (context, _) {
        final hasContent = emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty;

        return BlocBuilder<LoginCubit, LoginStates>(
          builder: (context, state) {
            final isLoading = state.loginState.state == StateType.loading;

            return SizedBox(
              height: 52.h,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: hasContent
                      ? AppColors.primaryColor
                      : AppColors.hintGrayColor,
                  foregroundColor: AppColors.whiteColor,
                  disabledBackgroundColor: AppColors.hintGrayColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                onPressed: (isLoading || !hasContent)
                    ? null
                    : () {
                        if (formKey.currentState!.validate()) {
                          context.read<LoginCubit>().doEvent(
                                LoginEvent(
                                  email: emailController.text.trim(),
                                  password: passwordController.text,
                                  rememberMe: rememberMe,
                                ),
                              );
                        }
                      },
                child: isLoading
                    ? SizedBox(
                        height: 22.h,
                        width: 22.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: AppColors.whiteColor,
                        ),
                      )
                    : Text(
                        AppLocalizations.of(context)!.continue_btn,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.whiteColor,
                        ),
                      ),
              ),
            );
          },
        );
      },
    );
  }
}
