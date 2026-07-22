import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/modules/app_section/view_model/app_section_state.dart';
import 'package:flowery/modules/app_section/view_model/app_section_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppSectionViewModel', () {
    late AppSectionViewModel appSectionViewModel;

    setUp(() {
      appSectionViewModel = AppSectionViewModel();
    });

    tearDown(() {
      appSectionViewModel.close();
    });

    test('initial state is AppSectionState with currentIndex 0', () {
      expect(appSectionViewModel.state, const AppSectionState());
      expect(appSectionViewModel.state.currentIndex, 0);
    });

    group('changeTab', () {
      blocTest<AppSectionViewModel, AppSectionState>(
        'emits new state with updated currentIndex when a different tab is selected',
        build: () => appSectionViewModel,
        act: (cubit) => cubit.changeTab(1),
        expect: () => [const AppSectionState(currentIndex: 1)],
      );

      blocTest<AppSectionViewModel, AppSectionState>(
        'emits nothing when the same tab index is selected again',
        build: () => appSectionViewModel,
        act: (cubit) => cubit.changeTab(0),
        expect: () => [],
      );

      blocTest<AppSectionViewModel, AppSectionState>(
        'emits correct state when switching between multiple tabs',
        build: () => appSectionViewModel,
        act: (cubit) {
          cubit.changeTab(1);
          cubit.changeTab(2);
        },
        expect: () => [
          const AppSectionState(currentIndex: 1),
          const AppSectionState(currentIndex: 2),
        ],
      );

      blocTest<AppSectionViewModel, AppSectionState>(
        'does not emit duplicate state when changeTab is called with current index repeatedly',
        build: () => appSectionViewModel,
        act: (cubit) {
          cubit.changeTab(1);
          cubit.changeTab(1);
        },
        expect: () => [const AppSectionState(currentIndex: 1)],
      );
    });

    group('goToHome', () {
      blocTest<AppSectionViewModel, AppSectionState>(
        'emits state with currentIndex 0 when called from a non-home tab',
        build: () => appSectionViewModel,
        seed: () => const AppSectionState(currentIndex: 2),
        act: (cubit) => cubit.goToHome(),
        expect: () => [const AppSectionState(currentIndex: 0)],
      );

      blocTest<AppSectionViewModel, AppSectionState>(
        'emits state with currentIndex 0 even when already on home tab',
        build: () => appSectionViewModel,
        act: (cubit) => cubit.goToHome(),
        expect: () => [const AppSectionState(currentIndex: 0)],
      );
    });

    group('isOnHomeTab', () {
      test('returns true when currentIndex is 0', () {
        expect(appSectionViewModel.isOnHomeTab, true);
      });

      blocTest<AppSectionViewModel, AppSectionState>(
        'returns false when currentIndex is not 0',
        build: () => appSectionViewModel,
        act: (cubit) => cubit.changeTab(1),
        verify: (cubit) => expect(cubit.isOnHomeTab, false),
      );
    });
  });
}