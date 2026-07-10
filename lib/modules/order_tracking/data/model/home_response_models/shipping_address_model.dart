import 'package:json_annotation/json_annotation.dart';

part 'shipping_address_model.g.dart';

@JsonSerializable()
class ShippingAddressModel {
  @JsonKey(name: 'street') final String? street;
  @JsonKey(name: 'city') final String? city;

  const ShippingAddressModel({this.street, this.city});

  factory ShippingAddressModel.fromJson(Map<String, dynamic> json) =>
      _$ShippingAddressModelFromJson(json);
  Map<String, dynamic> toJson() => _$ShippingAddressModelToJson(this);
}
