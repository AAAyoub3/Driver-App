import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.whiteColor,
        foregroundColor: AppColors.grayColor,
        side: BorderSide(color: AppColors.grayColor),
      ),
      child: Text(
        text,
        style: TextStyle(color: AppColors.grayColor),
      ),
    );
  }
}
