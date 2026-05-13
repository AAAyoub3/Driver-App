import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/core/const/app_strings.dart';
import 'package:flowery/core/const/occasions_values.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProductCard extends StatelessWidget {
  final String title;
  final String image;
  final double price;
  final bool hasDiscount;
  final double oldPrice;
  final double discount;
  final int sold;
  final int quantity;
  final List<String> images;
  const CustomProductCard({
    super.key,
    required this.title,
    required this.image,
    required this.price,
    this.hasDiscount = false,
    this.oldPrice = 0,
    this.discount = 0,
    required this.sold,
    required this.quantity,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushNamed(
        AppRoutes.productDetails,
        arguments: <String, dynamic>{
          OccasionsValues.title: title,
          OccasionsValues.image: image,
          OccasionsValues.price: price,
          OccasionsValues.discount: discount,
          OccasionsValues.sold: sold,
          OccasionsValues.quantity: quantity,
          OccasionsValues.images: images,
        },
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.onSecondary),
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: REdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: image,
                height: 130.h,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(fontSize: 12.sp),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 7.sp,
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
                        color: AppColors.greenColor,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
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
      ),
    );
  }
}
