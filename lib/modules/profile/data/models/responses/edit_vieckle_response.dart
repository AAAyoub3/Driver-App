import 'package:json_annotation/json_annotation.dart';

part 'edit_vieckle_response.g.dart';

@JsonSerializable()
class EditVieckleResponse {
  final String? message;
  final String? error;

  EditVieckleResponse({
    this.message,
    this.error,
  });

  factory EditVieckleResponse.fromJson(Map<String, dynamic> json) =>
      _$EditVieckleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EditVieckleResponseToJson(this);
}