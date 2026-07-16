// To parse this JSON data, do
//
//     final uploadProfilePhotoResponse = uploadProfilePhotoResponseFromJson(jsonString);

import 'package:flowery/modules/profile/domain/entities/upload_profile_photo_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'upload_profile_photo_response.g.dart';

UploadProfilePhotoResponse uploadProfilePhotoResponseFromJson(String str) =>
    UploadProfilePhotoResponse.fromJson(json.decode(str));

String uploadProfilePhotoResponseToJson(UploadProfilePhotoResponse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class UploadProfilePhotoResponse {
  @JsonKey(name: "message")
  String message;

  UploadProfilePhotoResponse({required this.message});

  factory UploadProfilePhotoResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadProfilePhotoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadProfilePhotoResponseToJson(this);

  UploadProfilePhotoEntity toDomain() =>
      UploadProfilePhotoEntity(message: message);
}
