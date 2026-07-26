import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entity/login_entity.dart';
part 'login_response_model.g.dart';
@JsonSerializable()
class LoginResponse {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "token")
  String? token;

  LoginResponse({
    this.message,
    this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
  LoginEntity toDomain() {
    return LoginEntity(
      message: message ?? '',
      token: token ?? '',
    );
  }
}


