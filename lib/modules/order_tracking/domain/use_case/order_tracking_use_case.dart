import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/order_tracking/domain/entities/driver_orders_response_entity.dart';
import 'package:flowery/modules/order_tracking/domain/repo/order_tracking_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrderTrackingUseCase {
  final OrderTrackingRepoContract repo;

  OrderTrackingUseCase({required this.repo});

  Future<Result<DriverOrdersResponseEntity>> call() {
    return repo.getOrders();
  }
}