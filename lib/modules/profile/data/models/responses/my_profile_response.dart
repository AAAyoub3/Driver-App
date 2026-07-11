// To parse this JSON data, do
//
//     final myProfileResponse = myProfileResponseFromJson(jsonString);

import 'package:flowery/modules/profile/domain/entities/my_profile_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_profile_response.g.dart';

@JsonSerializable()
class MyProfileResponse {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "country")
  String country;
  @JsonKey(name: "firstName")
  String firstName;
  @JsonKey(name: "lastName")
  String lastName;
  @JsonKey(name: "vehicleType")
  String vehicleType;
  @JsonKey(name: "vehicleNumber")
  String vehicleNumber;
  @JsonKey(name: "vehicleLicense")
  String vehicleLicense;
  @JsonKey(name: "NID")
  String nid;
  @JsonKey(name: "NIDImg")
  String nidImg;
  @JsonKey(name: "email")
  String email;
  @JsonKey(name: "gender")
  String gender;
  @JsonKey(name: "phone")
  String phone;
  @JsonKey(name: "photo")
  String photo;
  @JsonKey(name: "role")
  String role;
  @JsonKey(name: "createdAt")
  DateTime createdAt;
  @JsonKey(name: "passwordChangedAt")
  DateTime passwordChangedAt;

  MyProfileResponse({
    required this.id,
    required this.country,
    required this.firstName,
    required this.lastName,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.vehicleLicense,
    required this.nid,
    required this.nidImg,
    required this.email,
    required this.gender,
    required this.phone,
    required this.photo,
    required this.role,
    required this.createdAt,
    required this.passwordChangedAt,
  });

  factory MyProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$MyProfileResponseFromJson(json["driver"]);

  Map<String, dynamic> toJson() => _$MyProfileResponseToJson(this);

  String get fullName => '$firstName $lastName';

  MyProfileEntity toDomain() => MyProfileEntity(
    fullName: fullName,
    email: email,
    phone: phone,
    photo: photo,
    vehicleType: vehicleType,
    vehicleNumber: vehicleNumber,
  );
}
