import 'package:equatable/equatable.dart';

class ChangePasswordState extends Equatable {
  final bool isLoading;
  final bool isDone;
  final String? message;
  const ChangePasswordState({
    this.isLoading = false,
    this.message,
    this.isDone = false,
  });

  ChangePasswordState copyWith({
    final bool? isLoading,
    final bool? isDone,
    final String? message,
  }) => ChangePasswordState(
    isLoading: isLoading ?? this.isLoading,
    isDone: isDone ?? this.isDone,
    message: message ?? this.message,
  );
  @override
  List<Object?> get props => [isLoading, message];
}
