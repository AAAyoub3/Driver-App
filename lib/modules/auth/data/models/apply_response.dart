import 'package:flowery/modules/auth/data/models/driver.dart';
import 'package:flowery/modules/auth/domain/entities/apply_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'apply_response.g.dart';

@JsonSerializable()
class ApplyResponse {
  @JsonKey(name: "message")
  final String message;
  @JsonKey(name: "driver")
  final Driver driver;
  @JsonKey(name: "token")
  final String token;

  ApplyResponse({
    required this.message,
    required this.driver,
    required this.token,
  });

  factory ApplyResponse.fromJson(Map<String, dynamic> json) =>
      _$ApplyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApplyResponseToJson(this);

  ApplyResponseEntity toEntity() {
    return ApplyResponseEntity(
      message: message,
      driver: driver.toEntity(),
      token: token,
    );
  }
}