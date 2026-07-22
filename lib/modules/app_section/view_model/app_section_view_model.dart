import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_section_state.dart';

class AppSectionViewModel extends Cubit<AppSectionState> {
  AppSectionViewModel() : super(const AppSectionState());

  void changeTab(int index) {
    if (index == state.currentIndex) return;
    emit(state.copyWith(currentIndex: index));
  }

  void goToHome() {
    emit(state.copyWith(currentIndex: 0));
  }

  bool get isOnHomeTab => state.currentIndex == 0;
}