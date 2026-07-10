import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: '_id') final String? id;
  @JsonKey(name: 'firstName') final String? firstName;
  @JsonKey(name: 'lastName') final String? lastName;
  @JsonKey(name: 'photo') final String? photo;

  const UserModel({this.id, this.firstName, this.lastName, this.photo});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
