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
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Row(
            children: [
              /// LEFT SIDE (avatar + text)
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 22.sp,
                      backgroundImage: NetworkImage(icon),
                    ),
                    SizedBox(width: 10.w),

                    /// TEXT COLUMN
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 5.h),

                          Row(
                            children: [
                              Icon(Icons.location_on_outlined, size: 16.sp),
                              SizedBox(width: 4.w),

                              /// IMPORTANT: this Expanded fixes overflow
                              Expanded(
                                child: Text(
                                  address,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// RIGHT SIDE (buttons)
              Row(
                mainAxisSize: MainAxisSize.min,
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
      ),
    );
  }
}
