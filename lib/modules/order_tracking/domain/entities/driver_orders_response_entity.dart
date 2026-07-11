import 'package:equatable/equatable.dart';
import 'package:flowery/modules/order_tracking/domain/entities/driver_order_entity.dart';
import 'package:flowery/modules/order_tracking/domain/entities/product_entity.dart';
import 'package:flowery/modules/order_tracking/domain/entities/user_entity.dart';

class DriverOrdersResponseEntity extends Equatable {
  final String? message;
  final MetadataEntity? metadata;
  final List<DriverOrderEntity>? orders;

  const DriverOrdersResponseEntity({this.message, this.metadata, this.orders});

  @override
  List<Object?> get props => [message, metadata, orders];
}

class MetadataEntity extends Equatable {
  final int? currentPage;
  final int? totalPages;
  final int? totalItems;
  final int? limit;

  const MetadataEntity({
    this.currentPage,
    this.totalPages,
    this.totalItems,
    this.limit,
  });

  @override
  List<Object?> get props => [currentPage, totalPages, totalItems, limit];
}



class OrderEntity extends Equatable {
  final String? id;
  final UserEntity? user;
  final List<OrderItemEntity>? orderItems;
  final int? totalPrice;
  final String? paymentType;
  final bool? isPaid;
  final bool? isDelivered;
  final String? state;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? orderNumber;
  final int? v;

  const OrderEntity({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.v,
  });

  @override
  List<Object?> get props => [
    id,
    user,
    orderItems,
    totalPrice,
    paymentType,
    isPaid,
    isDelivered,
    state,
    createdAt,
    updatedAt,
    orderNumber,
    v,
  ];
}

class OrderItemEntity extends Equatable {
  final ProductEntity? product;
  final int? price;
  final int? quantity;
  final String? id;

  const OrderItemEntity({this.product, this.price, this.quantity, this.id});

  @override
  List<Object?> get props => [product, price, quantity, id];
}




