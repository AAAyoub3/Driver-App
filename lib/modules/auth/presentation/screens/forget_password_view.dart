import 'package:flowery/modules/auth/data/models/requestes/forget_password_request.dart';
import 'package:flowery/modules/auth/presentation/view_models/cubit/forget_password_view_model.dart';
import 'package:flowery/modules/auth/presentation/view_models/events/forget_password_evente.dart';
import 'package:flowery/modules/auth/presentation/view_models/states/forget_password_state.dart';
import 'package:flowery/modules/auth/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/base_state/base_state.dart';
import '../../../../config/di/injectable_config.dart';
import '../../../../config/helpers/validators.dart';
import '../../../../config/l10n/translations/app_localizations.dart';
import '../../../../config/routing/app_routes.dart';
import '../../../../config/routing/routing_extensions.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final GlobalKey<FormState> verifyEmailFormKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => getIt<ForgetPasswordViewModel>(),
      child: BlocConsumer<ForgetPasswordViewModel, ForgetPasswordState>(
        listenWhen: (prev, curr) =>
            prev.forgetPasswordState != curr.forgetPasswordState,

        listener: (context, state) {
          state.forgetPasswordState.when(
            success: (data) {
              // Pass the Cubit as an argument so the next route shares the
              // same instance — and the same email/timer state — via
              // BlocProvider.value in RouteGenerator.
              context.pushNamed(
                AppRoutes.emailVerification,
                arguments: context.read<ForgetPasswordViewModel>(),
              );
            },

            loading: () {},

            error: (exception) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(exception.toString())));
            },

            initial: () {},
          );
        },

        builder: (context, state) {
          final isLoading =
              state.forgetPasswordState.state == StateType.loading;

          return Scaffold(
            appBar: customAppBar(context),

            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),

              child: Form(
                key: verifyEmailFormKey,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    SizedBox(height: 38.h),

                    Center(
                      child: Text(
                        l10n.forget_password,

                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),

                    SizedBox(height: 10.h),

                    Text(
                      l10n.please_enter_your_email_associated_to_your_account,

                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.grayColor,
                      ),

                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 30.h),

                    CustomTextFormField(
                      hintText: l10n.enter_your_email,

                      labelText: l10n.email,

                      controller: emailController,

                      validator: (value) {
                        final error = Validations.validateEmail(value);

                        switch (error) {
                          case ValidationError.required:
                            return 'Email is required';

                          case ValidationError.invalidEmail:
                            return 'Invalid email';

                          default:
                            return null;
                        }
                      },
                    ),

                    SizedBox(height: 48.h),

                    CustomButton(
                      text: isLoading ? l10n.loading : l10n.confirm,

                      backgroundColor: AppColors.primaryColor,

                      foregroundColor: AppColors.whiteColor,

                      textColor: AppColors.whiteColor,

                      borderColor: AppColors.primaryColor,

                      onPressed: isLoading
                          ? null
                          : () {
                              if (verifyEmailFormKey.currentState!.validate()) {
                                context
                                    .read<ForgetPasswordViewModel>()
                                    .doIntent(
                                      event: SendEmailEvent(
                                        request: ForgetPasswordRequest(
                                          email: emailController.text.trim(),
                                        ),
                                      ),
                                    );
                              }
                            },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
