import 'package:flowery/modules/app_section/view_model/app_section_state.dart';
import 'package:flowery/modules/app_section/view_model/app_section_view_model.dart';
import 'package:flowery/modules/app_section/widget/app_section_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/app_section_bottom_nav_bar.dart';

class AppSectionScreen extends StatelessWidget {
  const AppSectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppSectionViewModel(),
      child: Scaffold(
        body: BlocBuilder<AppSectionViewModel, AppSectionState>(
          builder: (context, state) {
            return IndexedStack(
              index: state.currentIndex,
              children: const [
                // HomeScreen(),
                // OrdersScreen(),
                // ProfileScreen(),
              ],
            );
          },
        ),
        bottomNavigationBar: const AppSectionBottomNavBar(),
      ),
    );
  }
}
