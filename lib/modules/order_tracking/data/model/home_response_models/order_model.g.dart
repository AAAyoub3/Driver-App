// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
  id: json['_id'] as String?,
  orderNumber: json['orderNumber'] as String?,
  totalPrice: (json['totalPrice'] as num?)?.toDouble(),
  paymentType: json['paymentType'] as String?,
  state: json['state'] as String?,
  user: json['user'] == null
      ? null
      : UserModel.fromJson(json['user'] as Map<String, dynamic>),
  orderItems: (json['orderItems'] as List<dynamic>?)
      ?.map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  store: json['store'] == null
      ? null
      : StoreModel.fromJson(json['store'] as Map<String, dynamic>),
  shippingAddress: json['shippingAddress'] == null
      ? null
      : ShippingAddressModel.fromJson(
          json['shippingAddress'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'orderNumber': instance.orderNumber,
      'totalPrice': instance.totalPrice,
      'paymentType': instance.paymentType,
      'state': instance.state,
      'user': instance.user,
      'orderItems': instance.orderItems,
      'store': instance.store,
      'shippingAddress': instance.shippingAddress,
    };
