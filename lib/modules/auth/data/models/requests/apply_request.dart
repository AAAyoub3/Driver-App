import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';


class ApplyRequest {
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

  ApplyRequest({
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

  Future<MultipartFile> toMultiFile(XFile file) async {
    return MultipartFile.fromFile(
      file.path,
      filename: file.name,
    );
  }
}