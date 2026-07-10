import 'package:json_annotation/json_annotation.dart';

part 'store_model.g.dart';

@JsonSerializable()
class StoreModel {
  @JsonKey(name: 'name') final String? name;
  @JsonKey(name: 'image') final String? image;
  @JsonKey(name: 'address') final String? address;

  const StoreModel({this.name, this.image, this.address});

  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson(json);
  Map<String, dynamic> toJson() => _$StoreModelToJson(this);
}
