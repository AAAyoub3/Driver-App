import 'package:flowery/modules/order_tracking/data/models/response/driver_order.dart';
import 'package:flowery/modules/order_tracking/data/models/response/driver_orders_response.dart';
import 'package:flowery/modules/order_tracking/data/models/response/product.dart';
import 'package:flowery/modules/order_tracking/data/models/response/store.dart';
import 'package:flowery/modules/order_tracking/data/models/response/user.dart';
import 'package:flowery/modules/order_tracking/domain/entities/driver_order_entity.dart';
import 'package:flowery/modules/order_tracking/domain/entities/driver_orders_response_entity.dart';
import 'package:flowery/modules/order_tracking/domain/entities/product_entity.dart';
import 'package:flowery/modules/order_tracking/domain/entities/store_entity.dart';
import 'package:flowery/modules/order_tracking/domain/entities/user_entity.dart';

extension DriverOrdersResponseMapper on DriverOrdersResponse {
  DriverOrdersResponseEntity toDomain() {
    return DriverOrdersResponseEntity(
      message: message,
      metadata: metadata?.toDomain(),
      orders: orders?.map((e) => e.toDomain()).toList(),
    );
  }
}

extension MetadataMapper on Metadata {
  MetadataEntity toDomain() {
    return MetadataEntity(
      currentPage: currentPage,
      totalPages: totalPages,
      totalItems: totalItems,
      limit: limit,
    );
  }
}

extension OrderElementMapper on OrderElement {
  DriverOrderEntity toDomain() {
    return DriverOrderEntity(
      id: id,
      driverId: driver,
      order: order?.toDomain(),
      v: v,
      createdAt: createdAt,
      updatedAt: updatedAt,
      store: store?.toDomain(),
    );
  }
}

extension OrderOrderMapper on OrderOrder {
  OrderEntity toDomain() {
    return OrderEntity(
      id: id,
      user: user?.toDomain(),
      orderItems: orderItems?.map((e) => e.toDomain()).toList(),
      totalPrice: totalPrice,
      paymentType: paymentType,
      isPaid: isPaid,
      isDelivered: isDelivered,
      state: state,
      createdAt: createdAt,
      updatedAt: updatedAt,
      orderNumber: orderNumber,
      v: v,
    );
  }
}

extension OrderItemMapper on OrderItem {
  OrderItemEntity toDomain() {
    return OrderItemEntity(
      product: product?.toDomain(),
      price: price,
      quantity: quantity,
      id: id,
    );
  }
}

extension ProductMapper on Product {
  ProductEntity toDomain() {
    return ProductEntity(id: id, price: price);
  }
}

extension UserMapper on User {
  UserEntity toDomain() {
    return UserEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      gender: gender,
      phone: phone,
      photo: photo,
    );
  }
}

extension StoreMapper on Store {
  StoreEntity toDomain() {
    return StoreEntity(
      name: name,
      image: image,
      address: address,
      phoneNumber: phoneNumber,
      latLong: latLong,
    );
  }
}