import 'package:flowery/config/helpers/validation_error_mapper.dart';
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
      validator: (value) =>
          Validations.validateEmail(value)?.toMessage(l10n),
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
      validator: (value) =>
          Validations.validatePassword(value)?.toMessage(l10n),
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
