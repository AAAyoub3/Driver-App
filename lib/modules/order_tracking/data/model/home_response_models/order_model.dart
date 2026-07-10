import 'package:flowery/modules/order_tracking/domain/entity/home_entity/order_entity.dart';
import 'package:flowery/modules/order_tracking/domain/entity/home_entity/order_item_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import 'order_item_model.dart';
import 'shipping_address_model.dart';
import 'store_model.dart';
import 'user_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  @JsonKey(name: '_id') final String? id;
  @JsonKey(name: 'orderNumber') final String? orderNumber;
  @JsonKey(name: 'totalPrice') final double? totalPrice;
  @JsonKey(name: 'paymentType') final String? paymentType;
  @JsonKey(name: 'state') final String? state;
  @JsonKey(name: 'user') final UserModel? user;
  @JsonKey(name: 'orderItems') final List<OrderItemModel>? orderItems;
  @JsonKey(name: 'store') final StoreModel? store;
  @JsonKey(name: 'shippingAddress') final ShippingAddressModel? shippingAddress;

  const OrderModel({
    this.id,
    this.orderNumber,
    this.totalPrice,
    this.paymentType,
    this.state,
    this.user,
    this.orderItems,
    this.store,
    this.shippingAddress,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  OrderEntity toDomain() {
    String? userAddress;
    if (shippingAddress != null) {
      final parts = [shippingAddress!.street ?? '', shippingAddress!.city ?? '']
          .where((s) => s.isNotEmpty)
          .join(', ');
      userAddress = parts.isEmpty ? null : parts;
    }

    String? paymentMethod;
    if (paymentType == 'cash') {
      paymentMethod = 'Cash on delivery';
    } else if (paymentType != null) {
      paymentMethod = paymentType;
    }

    return OrderEntity(
      orderId: id,
      orderNumber: orderNumber,
      totalPrice: totalPrice,
      state: state,
      storeName: store?.name,
      storeImage: store?.image,
      storeAddress: store?.address,
      userName: '${user?.firstName ?? ''} ${user?.lastName ?? ''}'.trim(),
      userPhoto: user?.photo,
      userAddress: userAddress,
      userId: user?.id,
      paymentMethod: paymentMethod,
      items: orderItems
          ?.map((i) => OrderItemEntity(
                itemTitle: i.product?.title,
                itemIcon: i.product?.imgCover,
                itemCost: i.price?.toString(),
                itemCount: i.quantity?.toString(),
              ))
          .toList(),
    );
  }
}
