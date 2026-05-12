import 'dart:ui';
import 'package:flowery/config/general_cubit/general_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../helpers/shared_pref.dart';
import '../utils/constants.dart';

@injectable
class LocaleThemeCubit extends Cubit<LocaleThemeState> {
  final SharedPrefHelper sharedPrefHelper;

  LocaleThemeCubit(this.sharedPrefHelper)
      : super(
          LocaleThemeState(
            locale: Locale(
              sharedPrefHelper.getString(
                    AppConstants.languageCode,
                  ) ??
                  AppConstants.enKey,
            ),
            isDark:
                sharedPrefHelper.getBool(
                      AppConstants.isDark,
                    ) ??
                    false,
          ),
        );

  void changeLocale() {
    final lanCode = state.locale.languageCode;

    final newLocale =
        lanCode == AppConstants.enKey
            ? AppConstants.arKey
            : AppConstants.enKey;

    sharedPrefHelper.saveString(
      key: AppConstants.languageCode,
      value: newLocale,
    );

    emit(
      state.copyWith(
        locale: Locale(newLocale),
      ),
    );
  }

  void toggleTheme() {
    final newTheme = !state.isDark;

    sharedPrefHelper.saveBool(
      key: AppConstants.isDark,
      value: newTheme,
    );

    emit(
      state.copyWith(isDark: newTheme),
    );
  }
}
