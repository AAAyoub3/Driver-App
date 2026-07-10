import 'order_item_entity.dart';

class OrderEntity {
  final String? orderId;
  final String? orderNumber;
  final double? totalPrice;
  final String? state;
  final String? storeName;
  final String? storeImage;
  final String? storeAddress;
  final String? userName;
  final String? userPhoto;
  final String? userAddress;
  final String? userId;
  final String? paymentMethod;
  final List<OrderItemEntity>? items;

  const OrderEntity({
    this.orderId,
    this.orderNumber,
    this.totalPrice,
    this.state,
    this.storeName,
    this.storeImage,
    this.storeAddress,
    this.userName,
    this.userPhoto,
    this.userAddress,
    this.userId,
    this.paymentMethod,
    this.items,
  });
}
