// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_vieckle_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditVehicleRequest _$EditVehicleRequestFromJson(Map<String, dynamic> json) =>
    EditVehicleRequest(
      vehicleType: json['vehicleType'] as String,
      vehicleNumber: json['vehicleNumber'] as String,
      vehicleLicense: json['vehicleLicense'] as String,
    );

Map<String, dynamic> _$EditVehicleRequestToJson(EditVehicleRequest instance) =>
    <String, dynamic>{
      'vehicleType': instance.vehicleType,
      'vehicleNumber': instance.vehicleNumber,
      'vehicleLicense': instance.vehicleLicense,
    };
