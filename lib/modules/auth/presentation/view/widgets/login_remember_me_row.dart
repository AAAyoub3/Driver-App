import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginRememberMeRow extends StatelessWidget {
  const LoginRememberMeRow({
    super.key,
    required this.rememberMe,
    required this.onChanged,
    required this.onForgetPassword,
  });

  final bool rememberMe;
  final ValueChanged<bool> onChanged;
  final VoidCallback onForgetPassword;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        SizedBox(
          width: 24.w,
          height: 24.h,
          child: Checkbox(
            value: rememberMe,
            onChanged: (v) => onChanged(v ?? false),
            activeColor: AppColors.primaryColor,
            side: BorderSide(color: AppColors.hintGrayColor, width: 1.5.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.r),
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          l10n.remember_me,
          style: TextStyle(fontSize: 14.sp, color: AppColors.blackColor),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onForgetPassword,
          child: Text(
            l10n.forget_password_ques,
            style: TextStyle(fontSize: 14.sp, color: AppColors.hintGrayColor),
          ),
        ),
      ],
    );
  }
}
