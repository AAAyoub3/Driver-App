import 'package:dio/dio.dart';
import 'package:flowery/modules/auth/domain/entities/apply_body_entity.dart';
import 'package:image_picker/image_picker.dart';


class ApplyBody {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;
  final String repassword;
  final String gender;
  final String country;
  final String vehicleType;
  final String vehicleNumber;
  final XFile vehicleLicense;
  final String nid;
  final XFile nidImg;

  ApplyBody({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
    required this.repassword,
    required this.gender,
    required this.country,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.vehicleLicense,
    required this.nid,
    required this.nidImg,
  });

  Future<MultipartFile> toLicenseFile() async {
    return MultipartFile.fromFile(
      vehicleLicense.path,
      filename: vehicleLicense.name,
    );
  }

  Future<MultipartFile> toNidImgFile() async {
    return MultipartFile.fromFile(
      nidImg.path,
      filename: nidImg.name,
    );
  }

  factory ApplyBody.fromEntity(ApplyBodyEntity entity) {
    return ApplyBody(
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      phone: entity.phone,
      password: entity.password,
      repassword: entity.repassword,
      gender: entity.gender,
      country: entity.country,
      vehicleType: entity.vehicleType,
      vehicleNumber: entity.vehicleNumber,
      vehicleLicense: entity.vehicleLicense,
      nid: entity.nid,
      nidImg: entity.nidImg,
    );
  }

  ApplyBodyEntity toEntity() {
    return ApplyBodyEntity(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      password: password,
      repassword: repassword,
      gender: gender,
      country: country,
      vehicleType: vehicleType,
      vehicleNumber: vehicleNumber,
      vehicleLicense: vehicleLicense,
      nid: nid,
      nidImg: nidImg,
    );
  }
}