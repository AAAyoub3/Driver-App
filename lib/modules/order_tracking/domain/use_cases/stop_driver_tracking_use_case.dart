import 'package:flowery/modules/order_tracking/domain/repo/order_tracking_repo_contract.dart';
import 'package:injectable/injectable.dart';
@injectable
class StopDriverTrackingUseCase {
  
  final OrderTrackingRepoContract repo;
  StopDriverTrackingUseCase(this.repo);

  Future<void> call() {
    return repo.stopTracking();
  }
}