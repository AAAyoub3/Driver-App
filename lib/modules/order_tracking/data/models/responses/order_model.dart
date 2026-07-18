import 'package:flowery/modules/order_tracking/data/models/responses/order_item.dart';
import 'package:json_annotation/json_annotation.dart';
part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  final String? acceptedAt;
  final String? driverId;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? orderId;
  final String? orderNumber;
  final String? phone;
  final String? photo;
  final String? status;
  final String? storeAddress;
  final String? storeImage;
  final String? storeName;
  final double? totalPrice;
  final String? userAddress;
  final String? userName;
  final String? userPhoto;
  final String? userId;
  final String? vehicleNumber;
  final String? paymentMethod;
  final List<OrderItem>? items;

  const OrderModel({
    required this.acceptedAt,
    required this.driverId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.orderId,
    required this.orderNumber,
    required this.phone,
    required this.photo,
    required this.status,
    required this.storeAddress,
    required this.storeImage,
    required this.storeName,
    required this.totalPrice,
    required this.userAddress,
    required this.userName,
    required this.userPhoto,
    required this.userId,
    required this.vehicleNumber,
    required this.paymentMethod, 
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
