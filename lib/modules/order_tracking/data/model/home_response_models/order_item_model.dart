import 'package:json_annotation/json_annotation.dart';

import 'product_model.dart';

part 'order_item_model.g.dart';

@JsonSerializable()
class OrderItemModel {
  @JsonKey(name: 'product') final ProductModel? product;
  @JsonKey(name: 'price') final int? price;
  @JsonKey(name: 'quantity') final int? quantity;
  @JsonKey(name: '_id') final String? id;

  const OrderItemModel({this.product, this.price, this.quantity, this.id});

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);
}
