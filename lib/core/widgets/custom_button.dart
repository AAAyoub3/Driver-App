import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? textColor;
  final Color? borderColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.whiteColor,
        foregroundColor: foregroundColor ?? AppColors.grayColor,
        side: BorderSide(color: borderColor ?? AppColors.grayColor),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor ?? AppColors.grayColor),
      ),
    );
  }
}