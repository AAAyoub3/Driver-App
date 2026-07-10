import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/order_tracking/api/api_client/order_tracking_api_client.dart';
import 'package:flowery/modules/order_tracking/data/data_sources/orders_remote_data_sources_contract.dart';
import 'package:flowery/modules/order_tracking/data/model/driver_profile_response_model.dart';
import 'package:flowery/modules/order_tracking/data/model/home_response_models/home_respnose_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrderTrackingRemoteDataSourcesContract)
class OrderTrackingRemoteDataSourcesImpl
    extends OrderTrackingRemoteDataSourcesContract {
  final OrderTrackingApiClient apiClient;
  OrderTrackingRemoteDataSourcesImpl(this.apiClient);

  @override
  Future<Result<HomeResponseModel>> getHomeData({int page = 1}) async {
    try {
      final response = await apiClient.getHomeData(page);
      return Success(data: response);
    } catch (e) {
      return Error(exception: _handleException(e));
    }
  }

  @override
  Future<Result<DriverProfileResponseModel>> getDriverProfile() async {
    try {
      final response = await apiClient.getDriverProfile();
      return Success(data: response);
    } catch (e) {
      return Error(exception: _handleException(e));
    }
  }

  @override
  Future<Result<void>> startOrder(String orderId) async {
    try {
      await apiClient.startOrder(orderId);
      return const Success(data: null);
    } catch (e) {
      return Error(exception: _handleException(e));
    }
  }

  Exception _handleException(Object e) {
    if (e is DioException) return e;
    if (e is TimeoutException) return e;
    return Exception(e.toString());
  }
}
