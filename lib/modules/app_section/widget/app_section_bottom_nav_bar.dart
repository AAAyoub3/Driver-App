import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/modules/app_section/view_model/app_section_state.dart';
import 'package:flowery/modules/app_section/view_model/app_section_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AppSectionBottomNavBar extends StatelessWidget {
  const AppSectionBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return BlocBuilder<AppSectionViewModel, AppSectionState>(
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: state.currentIndex,
          onTap: (index) =>
              context.read<AppSectionViewModel>().changeTab(index),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primaryColor, // pink from your design
          unselectedItemColor: AppColors.hintGrayColor,
          showUnselectedLabels: true,
          items:  [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: localizations.home,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fact_check_outlined),
              activeIcon: Icon(Icons.fact_check),
              label: localizations.orders,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: localizations.profile,
            ),
          ],
        );
      },
    );
  }
}