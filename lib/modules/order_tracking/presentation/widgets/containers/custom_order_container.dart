import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOrderContainer extends StatefulWidget {
  final String icon;
  final String title;
  final String cost;
  final String numberOfItem;
  const CustomOrderContainer({
    super.key,
    required this.icon,
    required this.title,
    required this.cost,
    required this.numberOfItem,
  });

  @override
  State<CustomOrderContainer> createState() => _CustomOrderContainerState();
}

class _CustomOrderContainerState extends State<CustomOrderContainer> {
  // Localization
  late AppLocalizations localizations;

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: AppColors.lightPinkColor, width: 2.w),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: SizedBox(
          height: 76.h,
          width: 343.w,
          child: Row(
            children: [
              SizedBox(width: 10.w),
              CircleAvatar(
                radius: 22.sp,
                backgroundImage: NetworkImage(widget.icon),
              ),
              SizedBox(width: 10.w),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5.h),
                    Text("${widget.cost} ${localizations.egp}"),
                  ],
                ),
              ),
              Text(
                "X${widget.numberOfItem}",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10.w),
            ],
          ),
        ),
      ),
    );
  }
}
