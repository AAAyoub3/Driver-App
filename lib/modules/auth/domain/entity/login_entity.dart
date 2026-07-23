import 'package:equatable/equatable.dart';


class LoginEntity extends Equatable {
  final String message;
  final String token;

  const LoginEntity({
    required this.message,
    required this.token,
  });

  @override
  List<Object> get props => [
    message,
    token,
  ];
}