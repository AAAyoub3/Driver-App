import 'package:flowery/modules/auth/domain/entities/driver_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'driver.g.dart';

@JsonSerializable()
class Driver {
  @JsonKey(name: "country")
  final String country;
  @JsonKey(name: "firstName")
  final String firstName;
  @JsonKey(name: "lastName")
  final String lastName;
  @JsonKey(name: "vehicleType")
  final String vehicleType;
  @JsonKey(name: "vehicleNumber")
  final String vehicleNumber;
  @JsonKey(name: "vehicleLicense")
  final String vehicleLicense;
  @JsonKey(name: "NID")
  final String nid;
  @JsonKey(name: "NIDImg")
  final String nidImg;
  @JsonKey(name: "email")
  final String email;
  @JsonKey(name: "gender")
  final String gender;
  @JsonKey(name: "phone")
  final String phone;
  @JsonKey(name: "photo")
  final String photo;
  @JsonKey(name: "role")
  final String role;
  @JsonKey(name: "_id")
  final String id;
  @JsonKey(name: "createdAt")
  final DateTime createdAt;

  Driver({
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
    required this.id,
    required this.createdAt,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);

  Map<String, dynamic> toJson() => _$DriverToJson(this);

  DriverEntity toEntity() {
    return DriverEntity(
      country: country,
      firstName: firstName,
      lastName: lastName,
      vehicleType: vehicleType,
      vehicleNumber: vehicleNumber,
      vehicleLicense: vehicleLicense,
      nid: nid,
      nidImg: nidImg,
      email: email,
      gender: gender,
      phone: phone,
      photo: photo,
      role: role,
      id: id,
      createdAt: createdAt,
    );
  }
}