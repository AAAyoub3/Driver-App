import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final bool enabled;
  final Color unenabledColor;
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.enabled = true,
    this.unenabledColor = AppColors.hintGrayColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      enabled: enabled,
      controller: controller,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColors.blackColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColors.redColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: BorderSide(color: unenabledColor),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: .w400,
          color: AppColors.hintGrayColor,
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          fontWeight: .w400,
          fontSize: 14.sp,
          color: AppColors.blackColor,
        ),
      ),
    );
  }
}
