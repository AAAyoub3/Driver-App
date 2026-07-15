import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/order_tracking/data/data_sources/order_tracking_remote_data_sources_contract.dart';
import 'package:flowery/modules/order_tracking/data/mappers/driver_orders_mapper.dart';
import 'package:flowery/modules/order_tracking/domain/entities/driver_orders_response_entity.dart';
import 'package:flowery/modules/order_tracking/domain/repo/order_tracking_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrderTrackingRepoContract)
class OrderTrackingRepoImpl implements OrderTrackingRepoContract {
  final OrderTrackingRemoteDataSourcesContract remoteDataSources;
  OrderTrackingRepoImpl(this.remoteDataSources);

  @override
  Future<Result<DriverOrdersResponseEntity>> getOrders() async {
    final response = await remoteDataSources.getDriverOrders();

    return response.when(
      success: (data) {
        return Success<DriverOrdersResponseEntity>(data: data!.toDomain());
      },
      error: (exception) {
        return Error<DriverOrdersResponseEntity>(exception: exception);
      },
    );
  }
}
