import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class ApplyBodyEntity extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? password;
  final String? repassword;
  final String? gender;
  final String? country;
  final String? vehicleType;
  final String? vehicleNumber;
  final XFile? vehicleLicense;
  final String? nid;
  final XFile? nidImg;

  const ApplyBodyEntity({
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

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        phone,
        password,
        gender,
        country,
        vehicleType,
        vehicleNumber,
        vehicleLicense,
        nid,
        nidImg,
      ];
}