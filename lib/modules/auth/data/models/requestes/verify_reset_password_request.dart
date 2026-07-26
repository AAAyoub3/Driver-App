import 'package:json_annotation/json_annotation.dart';
part 'verify_reset_password_request.g.dart';

@JsonSerializable()
class VerifyResetPasswordRequest {
  @JsonKey(name: "resetCode")
  String? resetCode;

  VerifyResetPasswordRequest({
    this.resetCode,
  });

  factory VerifyResetPasswordRequest.fromJson(Map<String, dynamic> json) => _$VerifyResetPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyResetPasswordRequestToJson(this);
}