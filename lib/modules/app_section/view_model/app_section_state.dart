import 'package:equatable/equatable.dart';

class AppSectionState extends Equatable {
  final int currentIndex;

  const AppSectionState({this.currentIndex = 0});

  AppSectionState copyWith({int? currentIndex}) {
    return AppSectionState(currentIndex: currentIndex ?? this.currentIndex);
  }

  @override
  List<Object?> get props => [currentIndex];
}