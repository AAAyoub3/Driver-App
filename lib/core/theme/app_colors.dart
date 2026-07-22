import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primaryColor = Color(0xffD21E6A);
  static const Color lightPinkColor = Color(0xffF9ECF0);
  static const Color grayColor = Color(0xff535353);
  static const Color lightGrayColor = Color(0xff7D7D7D);
  static const Color darkGrayColor = Color(0xff878787);
  static const Color hintGrayColor = Color(0xffA6A6A6);
  static const Color redColor = Color(0xffB3261E);
  static const Color greenColor = Color(0xff0CB359);
  static const Color blackColor = Color(0xff0C1015);
  static const Color whiteColor = Color(0xffFFFFFF);
    static final Color greenColorWithOpacity12 =
      greenColor.withValues(alpha: 0.12);
    static final Color greenColorWithOpacity25 =
      greenColor.withValues(alpha: 0.25);
}