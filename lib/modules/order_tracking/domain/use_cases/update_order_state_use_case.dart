import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/order_tracking/data/models/responses/order_model.dart';
import 'package:flowery/modules/order_tracking/domain/repo/order_tracking_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateOrderStateUseCase {
  final OrderTrackingRepoContract repo;

  UpdateOrderStateUseCase(this.repo);

  Future<Result<OrderModel>> call(
    String orderId,
    String userId,
    String status,
    String title
  ) {
    return repo.updateOrderStatus(orderId, userId, status, title);
  }
}
