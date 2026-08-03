sealed class LoginEvents {}

class LoginEvent extends LoginEvents {
  final String email;
  final String password;
  final bool rememberMe;

  LoginEvent({
    required this.email,
    required this.password,
    this.rememberMe = false,
  });
}
