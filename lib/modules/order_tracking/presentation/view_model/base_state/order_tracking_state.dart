import 'package:equatable/equatable.dart';
import 'package:flowery/modules/order_tracking/domain/entities/driver_order_entity.dart';
import 'package:flutter/material.dart';

@immutable
class OrderTrackingState extends Equatable {
  final bool isLoadingOrders;
  final List<DriverOrderEntity> orders;
  final String? errorMessage;

  const OrderTrackingState({
    this.isLoadingOrders = false,
    this.orders = const [],
    this.errorMessage,
  });

  OrderTrackingState copyWith({
    bool? isLoadingOrders,
    List<DriverOrderEntity>? orders,
    String? errorMessage,
  }) {
    return OrderTrackingState(
      isLoadingOrders: isLoadingOrders ?? this.isLoadingOrders,
      orders: orders ?? this.orders,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoadingOrders, orders, errorMessage];
}
