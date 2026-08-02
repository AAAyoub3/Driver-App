
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/modules/profile/presentation/widgets/border_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VehicleTypeDropdown extends StatelessWidget {
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const VehicleTypeDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return BorderedField(
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          isDense: true,
          hint: Text(
            localizations.select_vehicle_type,
            style: TextStyle(fontSize: 15.sp, color: AppColors.darkGrayColor),
          ),
          icon: Icon(Icons.keyboard_arrow_down, size: 22.sp),
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
          ),
          items: items
              .map((type) => DropdownMenuItem(value: type, child: Text(type)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}