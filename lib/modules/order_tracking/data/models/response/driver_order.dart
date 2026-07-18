import 'package:flowery/modules/order_tracking/data/models/response/driver_orders_response.dart';
import 'package:flowery/modules/order_tracking/data/models/response/store.dart';
import 'package:json_annotation/json_annotation.dart';
part 'driver_order.g.dart';

@JsonSerializable()
class OrderElement {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "driver")
  String? driver;
  @JsonKey(name: "order")
  OrderOrder? order;
  @JsonKey(name: "__v")
  int? v;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;
  @JsonKey(name: "store")
  Store? store;

  OrderElement({
    this.id,
    this.driver,
    this.order,
    this.v,
    this.createdAt,
    this.updatedAt,
    this.store,
  });

  factory OrderElement.fromJson(Map<String, dynamic> json) =>
      _$OrderElementFromJson(json);

  Map<String, dynamic> toJson() => _$OrderElementToJson(this);
}
