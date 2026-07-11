import 'package:equatable/equatable.dart';
import 'package:flowery/modules/order_tracking/domain/entities/driver_orders_response_entity.dart';
import 'package:flowery/modules/order_tracking/domain/entities/store_entity.dart';

class DriverOrderEntity extends Equatable {
  final String? id;
  final String? driverId;
  final OrderEntity? order;
  final int? v;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final StoreEntity? store;

  const DriverOrderEntity({
    this.id,
    this.driverId,
    this.order,
    this.v,
    this.createdAt,
    this.updatedAt,
    this.store,
  });

  @override
  List<Object?> get props => [
    id,
    driverId,
    order,
    v,
    createdAt,
    updatedAt,
    store,
  ];
}