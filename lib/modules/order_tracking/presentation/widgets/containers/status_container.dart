import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusContainer extends StatefulWidget {
  final String status;
  final String orderId;
  final String date;
  const StatusContainer({
    super.key,
    required this.status,
    required this.orderId,
    required this.date,
  });

  @override
  State<StatusContainer> createState() => _StatusContainerState();
}

class _StatusContainerState extends State<StatusContainer> {
  // Localization
  late AppLocalizations localizations;

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      margin: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        color: AppColors.lightPinkColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: SizedBox(
        width: 343.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 5.sp,
          children: [
            Text(
              "${localizations.status} : ${widget.status}",
              style: TextStyle(color: AppColors.greenColor, fontSize: 16.sp),
            ),
            Text(
              "${localizations.order_id} : ${widget.orderId}",
              style: TextStyle(
                color: AppColors.blackColor,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
            Text(widget.date, style: TextStyle(fontSize: 14.sp)),
          ],
        ),
      ),
    );
  }
}
