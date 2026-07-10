import 'order_entity.dart';

class PaginatedOrdersEntity {
  final List<OrderEntity>? orders;
  final int? currentPage;
  final int? totalPages;
  final bool hasMore;

  const PaginatedOrdersEntity({
    this.orders,
    this.currentPage,
    this.totalPages,
    required this.hasMore,
  });
}
