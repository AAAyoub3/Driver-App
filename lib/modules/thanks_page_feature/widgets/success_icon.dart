import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SuccessIcon extends StatelessWidget {
  const SuccessIcon({super.key});



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              color: AppColors.greenColorWithOpacity12,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.greenColorWithOpacity25,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: AppColors.greenColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              color: AppColors.whiteColor,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}
