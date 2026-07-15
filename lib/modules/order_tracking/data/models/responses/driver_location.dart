import 'package:json_annotation/json_annotation.dart';
part 'driver_location.g.dart';
@JsonSerializable()
class DriverLocation {
  final double latitude;
  final double longitude;
  final double accuracy;
  final String updatedAt;

  DriverLocation({
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    required this.updatedAt,
  });

    factory DriverLocation.fromJson(Map<String, dynamic> json) =>
      _$DriverLocationFromJson(json);

  Map<String, dynamic> toJson() => _$DriverLocationToJson(this);
}