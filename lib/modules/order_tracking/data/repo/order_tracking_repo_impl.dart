import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/modules/order_tracking/data/data_sources/order_tracking_remote_data_sources_contract.dart';
import 'package:flowery/modules/order_tracking/data/models/responses/order_model.dart';
import 'package:flowery/modules/order_tracking/domain/repo/order_tracking_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrderTrackingRepoContract)
class OrderTrackingRepoImpl implements OrderTrackingRepoContract {
  final OrderTrackingRemoteDataSourcesContract remoteDataSources;
  OrderTrackingRepoImpl(this.remoteDataSources);

  @override
  Future<Result<OrderModel>> getOrderDetails(
    String driverId,
    AppLocalizations localizations,
  ) async {
    final response = await remoteDataSources.getOrderDetails(
      driverId,
      localizations,
    );
    switch (response) {
      case Success<OrderModel>():
        return Success<OrderModel>(data: response.data);
      case Error<OrderModel>():
        return Error<OrderModel>(exception: response.exception);
    }
  }

  @override
  Future<Result<OrderModel>> updateOrderStatus(
    String orderId,
    String userId,
    String status,
    String title,
    AppLocalizations localizations,
  ) async {
    final response = await remoteDataSources.updateOrderStatus(
      orderId,
      userId,
      status,
      title,
      localizations,
    );
    switch (response) {
      case Success<OrderModel>():
        return Success<OrderModel>(data: response.data);
      case Error<OrderModel>():
        return Error<OrderModel>(exception: response.exception);
    }
  }

  @override
  Future<void> startTracking(String driverId) {
    return remoteDataSources.startTracking(driverId);
  }

  @override
  Future<void> stopTracking() {
    return remoteDataSources.stopTracking();
  }

  @override
  Future<Result<String>> getUserLanguage(String userId) async {
    final response = await remoteDataSources.getUserLanguage(userId);
    switch (response) {
      case Success<String>():
        return Success<String>(data: response.data);
      case Error<String>():
        return Error<String>(exception: response.exception);
    }
  }
}
