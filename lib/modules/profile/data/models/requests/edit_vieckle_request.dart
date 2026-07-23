import 'package:json_annotation/json_annotation.dart';

part 'edit_vieckle_request.g.dart';

@JsonSerializable()
class EditVehicleRequest {
  final String vehicleType;
  final String vehicleNumber;
  final String vehicleLicense;

  EditVehicleRequest({
    required this.vehicleType,
    required this.vehicleNumber,
    required this.vehicleLicense, String? vehicleLicensePath,
  });

  factory EditVehicleRequest.fromJson(Map<String, dynamic> json) =>
      _$EditVehicleRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EditVehicleRequestToJson(this);
}