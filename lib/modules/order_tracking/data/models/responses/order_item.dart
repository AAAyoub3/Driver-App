import 'package:json_annotation/json_annotation.dart';

part 'order_item.g.dart';
@JsonSerializable()
class OrderItem {
  final String? itemCost;
  final String? itemCount;
  final String? itemIcon;
  final String? itemTitle;

  OrderItem({
    required this.itemCost,
    required this.itemCount,
    required this.itemIcon,
    required this.itemTitle,
  });

    factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}
