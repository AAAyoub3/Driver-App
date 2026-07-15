import 'package:dio/dio.dart';
import 'package:flowery/config/api/app_endpoints.dart';
import 'package:flowery/modules/order_tracking/data/models/response/driver_orders_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'order_tracking_api_client.g.dart';

@injectable
@RestApi()
abstract class OrderTrackingApiClient {
  @factoryMethod
  factory OrderTrackingApiClient(Dio dio) = _OrderTrackingApiClient;

  @GET(AppEndPoints.orders)
  Future<DriverOrdersResponse> getDriverOrders();
}
