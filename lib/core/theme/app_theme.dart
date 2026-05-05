import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.whiteColor,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryColor,
      secondary: AppColors.lightPinkColor,
      error: AppColors.redColor,
      surface: AppColors.whiteColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        minimumSize: Size(double.infinity, 50.h),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.whiteColor,
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: .w500,
          color: AppColors.whiteColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.r),
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 20.sp,
        fontWeight: .w500,
        color: AppColors.blackColor,
      ),
    ),
    textTheme: TextTheme(
      labelSmall: TextStyle(
        fontWeight: .w400,
        fontSize: 14.sp,
        color: AppColors.blackColor,
        decoration: TextDecoration.underline,
        decorationColor: AppColors.blackColor,
        decorationThickness: 1.w,
      ),
      labelMedium: TextStyle(
        fontWeight: .w500,
        fontSize: 16.sp,
        color: AppColors.primaryColor,
        decoration: TextDecoration.underline,
        decorationColor: AppColors.primaryColor,
        decorationThickness: 1.w,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.whiteColor;
        }
        return null;
      }),
      trackColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryColor;
        }
        return null;
      }),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryColor;
        }
        return null;
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.whiteColor;
        }
        return null;
      }),
      fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryColor;
        }
        return null;
      }),
    ),
  );
}
