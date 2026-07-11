import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/core/consts/orders_values.dart';
import 'package:flowery/modules/order_tracking/api/api_client/order_tracking_api_client.dart';
import 'package:flowery/modules/order_tracking/data/data_sources/order_tracking_remote_data_sources_contract.dart';
import 'package:flowery/modules/order_tracking/data/models/response/driver_orders_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrderTrackingRemoteDataSourcesContract)
class OrderTrackingRemoteDataSourcesImpl
    extends OrderTrackingRemoteDataSourcesContract {
  final OrderTrackingApiClient apiClient;
  OrderTrackingRemoteDataSourcesImpl(this.apiClient);

  @override
  Future<Result<DriverOrdersResponse>> getOrders() async {
    try {
      final response = await apiClient.getOrders();
      return Success<DriverOrdersResponse>(data: response);
    } on DioException catch (e) {
      return Error<DriverOrdersResponse>(
        exception: Exception(e.response?.data[OrderValues.error]),
      );
    }
  }
}
