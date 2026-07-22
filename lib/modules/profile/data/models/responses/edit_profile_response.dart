import 'package:flowery/modules/profile/domain/entities/edit_profile_photo_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'edit_profile_response.g.dart';

EditProfileResponse editProfileResponseFromJson(String str) =>
    EditProfileResponse.fromJson(json.decode(str));

String editProfileResponseToJson(EditProfileResponse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class EditProfileResponse {
  @JsonKey(name: "message")
  String message;

  EditProfileResponse({required this.message});

  factory EditProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$EditProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileResponseToJson(this);

  EditProfileEntity toDomain() => EditProfileEntity( message : message);
}
