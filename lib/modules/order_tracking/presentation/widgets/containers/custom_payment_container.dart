import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPaymentContainer extends StatelessWidget {
  final String title;
  final String value;
  const CustomPaymentContainer({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: AppColors.lightPinkColor, width: 2.w),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: SizedBox(
        height: 50.h,
        width: 343.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(width: 5.w),
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
              children: [
                Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 2.w),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
