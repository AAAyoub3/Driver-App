import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/modules/order_tracking/data/models/responses/order_model.dart';
import 'package:flowery/modules/order_tracking/domain/repo/order_tracking_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOrderDetailsUseCase {
  final OrderTrackingRepoContract repo;
  GetOrderDetailsUseCase(this.repo);

  Future<Result<OrderModel>> call(String driverId,
    AppLocalizations localizations) {
    return repo.getOrderDetails(driverId,localizations);
  }
}
