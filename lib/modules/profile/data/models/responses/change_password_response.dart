import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/modules/profile/domain/entities/change_password_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'change_password_response.g.dart';

ChangePasswordResponse changePasswordResponseFromJson(String str) =>
    ChangePasswordResponse.fromJson(json.decode(str));

String changePasswordResponseToJson(ChangePasswordResponse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ChangePasswordResponse {
  @JsonKey(name: Apikeys.message)
  String? message;
  @JsonKey(name: Apikeys.token)
  String? token;
  @JsonKey(name: Apikeys.error)
  String? error;

  ChangePasswordResponse({this.message, this.token, this.error});

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordResponseToJson(this);

  ChangePasswordEntity toEntity() => ChangePasswordEntity(message: message ?? "");
}
