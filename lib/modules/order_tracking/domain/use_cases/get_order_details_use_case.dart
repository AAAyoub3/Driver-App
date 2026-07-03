import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/order_tracking/data/models/order_model.dart';
import 'package:flowery/modules/order_tracking/domain/repo/order_tracking_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOrderDetailsUseCase {
  final OrderTrackingRepoContract repo;
  GetOrderDetailsUseCase(this.repo);

  Future<Result<OrderModel>> call(String driverId) {
    return repo.getOrderDetails(driverId);
  }
}
