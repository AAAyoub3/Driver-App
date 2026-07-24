import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/widgets/custom_drop_down_field.dart';
import 'package:flowery/modules/auth/domain/entities/country_entity.dart';
import 'package:flowery/modules/auth/presentation/screen_validators/apply_screen_validators.dart';
import 'package:flowery/modules/auth/presentation/view_model/cubit/apply_cubit.dart';
import 'package:flowery/modules/auth/presentation/view_model/events/apply_events.dart';
import 'package:flowery/modules/auth/presentation/view_model/state/apply_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountriesDropDownMenu extends StatefulWidget {
  const CountriesDropDownMenu({super.key});

  @override
  State<CountriesDropDownMenu> createState() => _CountriesDropDownMenuState();
}

class _CountriesDropDownMenuState extends State<CountriesDropDownMenu> {
  late AppLocalizations localizations;
  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<ApplyCubit, ApplyState>(
          builder: (context, state) {
            return state.countriesState.when(
              success: (List<CountryEntity> countries) {
                return CustomDropdownField<CountryEntity>(
                  labelText: localizations.country,
                  hintText: localizations.chooseCountry,
                  value: state.selectedCountry,
                  items: countries,
                  itemAsString: (country) =>
                      "${country.flag}   ${country.name} (${country.phoneCode})",
                  onChanged: (country) {
                    context.read<ApplyCubit>().doEvent(
                      SelectCountryEvent(selectedCountry: country),
                    );
                  },
                  validator: (value) => ApplyScreenValidators.validateCountry(
                    value,
                    localizations.validationCountryRequired,
                  ),
                );
              },
              loading: () => CircularProgressIndicator(),
              error: (error) => Text(error.toString()),
              initial: () => SizedBox.shrink(),
            );
          },
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
