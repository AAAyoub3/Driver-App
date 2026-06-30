import 'package:equatable/equatable.dart';

class ChangePasswordEntity extends Equatable {
  final String message;

  const ChangePasswordEntity({required this.message});
  
  @override
  List<Object?> get props => [message];
}
