sealed class EditProfileEvents {}

class UpdateProfileInfoEvent extends EditProfileEvents {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String gender;
  UpdateProfileInfoEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.gender,
  });
}


class GenderChanged extends EditProfileEvents {
  final String gender;
  GenderChanged(this.gender);
}