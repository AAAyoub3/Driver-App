sealed class LoginEvents {}

class LoginEvent extends LoginEvents {
  final String email;
  final String password;

  LoginEvent({
    required this.email,
    required this.password,
  });
}

class NavigateToRegisterEvent extends LoginEvents {}

