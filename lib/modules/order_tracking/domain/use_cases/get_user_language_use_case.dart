import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/order_tracking/domain/repo/order_tracking_repo_contract.dart';
import 'package:injectable/injectable.dart';
@injectable
class GetUserLanguageUseCase {

  final OrderTrackingRepoContract repo;
  GetUserLanguageUseCase(this.repo);

  Future<Result<String>> call(String userId) {
    return repo.getUserLanguage(userId);
  }
}
