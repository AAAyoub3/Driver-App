import 'package:flowery/modules/order_tracking/domain/entity/home_entity/order_entity.dart';

abstract class HomeEvent {}

class GetOrdersEvent extends HomeEvent {
  final int page;
  GetOrdersEvent({this.page = 1});
}

class RejectOrderEvent extends HomeEvent {
  final String orderId;
  RejectOrderEvent({required this.orderId});
}

class AcceptOrderEvent extends HomeEvent {
  final OrderEntity order;
  AcceptOrderEvent({required this.order});
}
