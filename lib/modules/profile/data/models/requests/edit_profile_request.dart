import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_request.g.dart';

@JsonSerializable()
class EditProfileRequest {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  // final String gender;

  EditProfileRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    // required this.gender,
  });

  factory EditProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$EditProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileRequestToJson(this);
}