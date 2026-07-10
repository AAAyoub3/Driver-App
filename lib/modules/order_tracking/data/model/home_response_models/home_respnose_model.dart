import 'package:json_annotation/json_annotation.dart';

import 'metadata_model.dart';
import 'order_model.dart';

part 'home_respnose_model.g.dart';

@JsonSerializable()
class HomeResponseModel {
  @JsonKey(name: 'message') final String? message;
  @JsonKey(name: 'metadata') final MetadataModel? metadata;
  @JsonKey(name: 'orders') final List<OrderModel>? orders;

  const HomeResponseModel({this.message, this.metadata, this.orders});

  factory HomeResponseModel.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$HomeResponseModelToJson(this);
}
