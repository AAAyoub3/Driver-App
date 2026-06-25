import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAddressContainer extends StatelessWidget {
  final String icon;
  final String title;
  final String address;
  const CustomAddressContainer({
    super.key,
    required this.icon,
    required this.title,
    required this.address,
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
        height: 76.h,
        width: 343.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22.sp,
                  backgroundImage: NetworkImage(icon),
                ),
                SizedBox(width: 10.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5.sp,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 5.w),
                        Text(title),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, size: 16.sp),
                        Text(address),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.call, color: AppColors.primaryColor),
                ),
                IconButton(
                  onPressed: () {},
                  icon: FaIcon(
                    FontAwesomeIcons.whatsapp,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
