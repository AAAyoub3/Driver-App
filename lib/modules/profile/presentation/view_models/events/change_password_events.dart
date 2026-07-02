sealed class ChangePasswordEvents {}

class UpdatePasswordEvent extends ChangePasswordEvents {
  final String password;
  final String newPassword;

  UpdatePasswordEvent({required this.password, required this.newPassword});
}
