import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final String labelText;
  final String hintText;
  final T? value;
  final List<T> items;
  final String Function(T) itemAsString;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;

  const CustomDropdownField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.value,
    required this.items,
    required this.itemAsString,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      isExpanded: true,
      items: items.map((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(
            itemAsString(item),
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.blackColor,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
      selectedItemBuilder: (context) {
        return items.map((T item) {
          return Text(
            itemAsString(item),
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.blackColor,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          );
        }).toList();
      },
      onChanged: onChanged,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: AppColors.hintGrayColor,
        size: 24.sp,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: BorderSide(color: AppColors.blackColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: BorderSide(color: AppColors.blackColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: BorderSide(color: AppColors.redColor),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.hintGrayColor,
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
          color: AppColors.blackColor,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}