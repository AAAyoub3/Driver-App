import 'package:dio/dio.dart';
import 'package:flowery/config/api/app_endpoints.dart';
import 'package:flowery/modules/order_tracking/data/model/driver_profile_response_model.dart';
import 'package:flowery/modules/order_tracking/data/model/home_response_models/home_respnose_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'order_tracking_api_client.g.dart';

@injectable
@RestApi()
abstract class OrderTrackingApiClient {
  @factoryMethod
  factory OrderTrackingApiClient(Dio dio) = _OrderTrackingApiClient;

  @GET(AppEndPoints.pendingOrders)
  Future<HomeResponseModel> getHomeData(@Query('page') int page);

  @GET(AppEndPoints.driverProfile)
  Future<DriverProfileResponseModel> getDriverProfile();

  @PUT('${AppEndPoints.startOrder}{orderId}')
  Future<void> startOrder(@Path('orderId') String orderId);
}
