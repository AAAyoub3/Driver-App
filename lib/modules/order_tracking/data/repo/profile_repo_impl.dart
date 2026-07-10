import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/order_tracking/data/data_sources/firestore_data_source.dart';
import 'package:flowery/modules/order_tracking/data/data_sources/orders_remote_data_sources_contract.dart';
import 'package:flowery/modules/order_tracking/data/model/driver_profile_response_model.dart';
import 'package:flowery/modules/order_tracking/data/model/home_response_models/home_respnose_model.dart';
import 'package:flowery/modules/order_tracking/domain/entity/home_entity/order_entity.dart';
import 'package:flowery/modules/order_tracking/domain/entity/home_entity/paginated_orders_entity.dart';
import 'package:flowery/modules/order_tracking/domain/repo/profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrderTrackingRepoContract)
class OrderTrackingRepoImpl extends OrderTrackingRepoContract {
  final OrderTrackingRemoteDataSourcesContract remoteDataSources;
  final FirestoreDataSource firestoreDataSource;

  OrderTrackingRepoImpl(this.remoteDataSources, this.firestoreDataSource);

  @override
  Future<Result<PaginatedOrdersEntity>> getOrders({int page = 1}) async {
    final response = await remoteDataSources.getHomeData(page: page);
    switch (response) {
      case Success<HomeResponseModel>():
        return Success<PaginatedOrdersEntity>(
          data: PaginatedOrdersEntity(
            orders: response.data?.orders?.map((o) => o.toDomain()).toList() ?? [],
            currentPage: response.data?.metadata?.currentPage,
            totalPages: response.data?.metadata?.totalPages,
            hasMore: (response.data?.metadata?.currentPage ?? 0) <
                (response.data?.metadata?.totalPages ?? 0),
          ),
        );
      case Error<HomeResponseModel>(:final exception):
        return Error<PaginatedOrdersEntity>(exception: exception);
    }
  }

  @override
  Future<Result<void>> acceptOrder(OrderEntity order) async {
    // Step 1: call start order API
    final startResult = await remoteDataSources.startOrder(order.orderId ?? '');
    switch (startResult) {
      case Error<void>(:final exception):
        return Error<void>(exception: exception);
      case Success<void>():
        // Step 2: get driver profile
        final profileResult = await remoteDataSources.getDriverProfile();
        switch (profileResult) {
          case Error<DriverProfileResponseModel>(:final exception):
            return Error<void>(exception: exception);
          case Success<DriverProfileResponseModel>():
            try {
              // Step 3: save to Firestore
              await firestoreDataSource.saveAcceptedOrder(
                order: order,
                driver: profileResult.data!,
              );
              return const Success<void>(data: null);
            } catch (e) {
              return Error<void>(exception: Exception(e.toString()));
            }
        }
    }
  }
}
