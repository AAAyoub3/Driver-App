import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BorderedField extends StatelessWidget {
  final Widget child;
  const BorderedField({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightPinkColor),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: child,
    );
  }
}