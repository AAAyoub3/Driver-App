import 'package:flowery/config/helpers/validators.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginEmailField extends StatelessWidget {
  const LoginEmailField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return CustomTextFormField(
      labelText: l10n.email,
      hintText: l10n.enter_your_email,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        final error = Validations.validateEmail(value);
        return switch (error) {
          ValidationError.invalidEmail => l10n.email_is_not_valid,
          _ => null,
        };
      },
    );
  }
}

class LoginPasswordField extends StatelessWidget {
  const LoginPasswordField({
    super.key,
    required this.controller,
    required this.isObscure,
    required this.onToggle,
  });

  final TextEditingController controller;
  final bool isObscure;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return CustomTextFormField(
      labelText: l10n.password,
      hintText: l10n.enter_your_password,
      controller: controller,
      obscureText: isObscure,
      validator: (value) {
        final error = Validations.validatePassword(value);
        return switch (error) {
          ValidationError.invalidPassword => l10n.password_is_not_valid,
          _ => null,
        };
      },
      suffixIcon: IconButton(
        onPressed: onToggle,
        icon: Icon(
          isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: AppColors.hintGrayColor,
          size: 20.sp,
        ),
      ),
    );
  }
}
