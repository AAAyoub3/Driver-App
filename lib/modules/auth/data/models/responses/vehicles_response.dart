// To parse this JSON data, do
//
//     final vehiclesResponse = vehiclesResponseFromJson(jsonString);

import 'package:flowery/modules/auth/data/models/responses/vehicle_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'vehicles_response.g.dart';

VehiclesResponse vehiclesResponseFromJson(String str) => VehiclesResponse.fromJson(json.decode(str));

String vehiclesResponseToJson(VehiclesResponse data) => json.encode(data.toJson());

@JsonSerializable()
class VehiclesResponse {
    @JsonKey(name: "message")
    String? message;
    @JsonKey(name: "metadata")
    Metadata? metadata;
    @JsonKey(name: "vehicles")
    List<Vehicle>? vehicles;

    VehiclesResponse({
        this.message,
        this.metadata,
        this.vehicles,
    });

    factory VehiclesResponse.fromJson(Map<String, dynamic> json) => _$VehiclesResponseFromJson(json);

    Map<String, dynamic> toJson() => _$VehiclesResponseToJson(this);
}

@JsonSerializable()
class Metadata {
    @JsonKey(name: "currentPage")
    int? currentPage;
    @JsonKey(name: "totalPages")
    int? totalPages;
    @JsonKey(name: "limit")
    int? limit;
    @JsonKey(name: "totalItems")
    int? totalItems;

    Metadata({
        this.currentPage,
        this.totalPages,
        this.limit,
        this.totalItems,
    });

    factory Metadata.fromJson(Map<String, dynamic> json) => _$MetadataFromJson(json);

    Map<String, dynamic> toJson() => _$MetadataToJson(this);
}


