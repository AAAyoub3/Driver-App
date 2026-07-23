import 'package:flowery/modules/auth/domain/entities/vehicle_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle_model.g.dart';

@JsonSerializable()
class Vehicle {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;
  @JsonKey(name: "__v")
  int? v;

  Vehicle({
    this.id,
    this.type,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) =>
      _$VehicleFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleToJson(this);

  VehicleEntity toEntity() => VehicleEntity(id: id, type: type);
}
