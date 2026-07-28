import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/modules/auth/presentation/screen_strings/apply_screen_strings.dart';
import 'package:flowery/modules/auth/presentation/view_model/cubit/apply_cubit.dart';
import 'package:flowery/modules/auth/presentation/view_model/events/apply_events.dart';
import 'package:flowery/modules/auth/presentation/view_model/state/apply_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenderContainer extends StatefulWidget {
  const GenderContainer({super.key});

  @override
  State<GenderContainer> createState() => _GenderContainerState();
}

class _GenderContainerState extends State<GenderContainer> {
  late AppLocalizations localizations;
  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplyCubit, ApplyState>(
      builder: (context, state) {
        return RadioGroup<String>(
          groupValue: state.selectedGender,
          onChanged: (gender) {
            context.read<ApplyCubit>().doEvent(
              SelectGenderEvent(selectedGender: gender),
            );
          },
          child: Row(
            children: [
              Text(localizations.gender),
              SizedBox(width: 20.w),
              Row(
                children: [
                  Radio<String>(
                    value: ApplyScreenStrings.male,
                    activeColor: AppColors.primaryColor,
                  ),
                  Text(localizations.male),
                ],
              ),
              SizedBox(width: 20.w),
              Row(
                children: [
                  Radio<String>(
                    value: ApplyScreenStrings.female,
                    activeColor: AppColors.primaryColor,
                  ),
                  Text(localizations.female),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
