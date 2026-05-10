import 'package:flowery/core/const/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGridWidget extends StatelessWidget {
  final String title;
  final String image;
  final double price;
  final bool hasDiscount;
  final double oldPrice;
  final double discount;
  const CustomGridWidget({
    super.key,
    required this.title,
    required this.image,
    required this.price,
    this.hasDiscount = false,
    this.oldPrice = 0,
    this.discount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.onSecondary),
        borderRadius: BorderRadius.circular(8.r),
      ),
      padding: REdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            image,
            height: 130.h,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(fontSize: 12.sp),
                ),
                Row(
                  spacing: 8.w,
                  children: [
                    Text(
                      "EGP $price",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: .w500,
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      "$oldPrice",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Theme.of(
                          context,
                        ).colorScheme.onSecondary,
                        decorationThickness: 1.w,
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 12.sp,
                      ),
                    ),
                    Text(
                      "$discount%",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: .w400,
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          ElevatedButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart_outlined, size: 16.sp),
                SizedBox(width: 4.w),
                Text(
                  AppStrings.addToCart,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
