import 'package:flowery/modules/order_tracking/domain/repo/order_tracking_repo_contract.dart';
import 'package:injectable/injectable.dart';
@injectable
class StartDriverTrackingUseCase {

  final OrderTrackingRepoContract repo;
  StartDriverTrackingUseCase(this.repo);

  Future<void> call(String driverId) {
    return repo.startTracking(driverId);
  }
}
