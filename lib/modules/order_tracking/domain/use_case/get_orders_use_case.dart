import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/order_tracking/domain/entity/home_entity/paginated_orders_entity.dart';
import 'package:flowery/modules/order_tracking/domain/repo/profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOrdersUseCase {
  final OrderTrackingRepoContract repo;
  GetOrdersUseCase(this.repo);

  Future<Result<PaginatedOrdersEntity>> call({int page = 1}) =>
      repo.getOrders(page: page);
}
