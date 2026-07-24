import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/modules/order_tracking/domain/entity/home_entity/order_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderCardWidget extends StatelessWidget {
  final OrderEntity order;
  final VoidCallback onReject;
  final VoidCallback onAccept;

  const OrderCardWidget({
    super.key,
    required this.order,
    required this.onReject,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 10.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.flower_order,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            l10n.pick_up_address,
            style: TextStyle(fontSize: 12.sp, color: AppColors.grayColor),
          ),
          SizedBox(height: 6.h),
          _AddressRow(
            imageUrl: order.storeImage,
            name: order.storeName ?? '',
            address: order.storeAddress ?? '',
          ),
          SizedBox(height: 12.h),
          Text(
            l10n.user_address,
            style: TextStyle(fontSize: 12.sp, color: AppColors.grayColor),
          ),
          SizedBox(height: 6.h),
          _AddressRow(
            imageUrl: order.userPhoto,
            name: order.userName ?? '',
            address: order.userAddress ?? '',
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Text(
                '${l10n.egp} ${order.totalPrice?.toStringAsFixed(0) ?? '0'}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackColor,
                ),
              ),
              const Spacer(),
              _ActionButton(
                label: l10n.reject,
                onPressed: onReject,
                filled: false,
              ),
              SizedBox(width: 8.w),
              _ActionButton(
                label: l10n.accept,
                onPressed: onAccept,
                filled: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AddressRow extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final String address;

  const _AddressRow({
    required this.imageUrl,
    required this.name,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    final isNetwork = imageUrl != null && imageUrl!.startsWith('http');

    return Container(
      height: 64.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightPinkColor, width: 1.w),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundColor: AppColors.lightPinkColor,
            backgroundImage: isNetwork ? NetworkImage(imageUrl!) : null,
            child: isNetwork
                ? null
                : Icon(Icons.person, size: 22.sp, color: AppColors.primaryColor),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined,
                        size: 12.sp, color: AppColors.grayColor),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Text(
                        address,
                        style: TextStyle(
                            fontSize: 11.sp, color: AppColors.grayColor),
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
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool filled;

  const _ActionButton({
    required this.label,
    required this.onPressed,
    required this.filled,
  });

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.r),
    );
    final padding = EdgeInsets.symmetric(horizontal: 20.w);

    if (filled) {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.whiteColor,
          minimumSize: Size(80.w, 36.h),
          shape: shape,
          padding: padding,
          elevation: 0,
        ),
        child: Text(label, style: TextStyle(fontSize: 13.sp)),
      );
    }

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        side: BorderSide(color: AppColors.primaryColor, width: 1.w),
        minimumSize: Size(80.w, 36.h),
        shape: shape,
        padding: padding,
      ),
      child: Text(label, style: TextStyle(fontSize: 13.sp)),
    );
  }
}
