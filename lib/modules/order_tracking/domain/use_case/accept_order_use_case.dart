import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/order_tracking/domain/entity/home_entity/order_entity.dart';
import 'package:flowery/modules/order_tracking/domain/repo/profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class AcceptOrderUseCase {
  final OrderTrackingRepoContract repo;
  AcceptOrderUseCase(this.repo);

  Future<Result<String>> call(OrderEntity order) => repo.acceptOrder(order);
}
