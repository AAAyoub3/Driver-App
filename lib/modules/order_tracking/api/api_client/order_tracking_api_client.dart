import 'package:dio/dio.dart';
import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/config/api/app_endpoints.dart';
import 'package:flowery/modules/order_tracking/data/models/notification_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'order_tracking_api_client.g.dart';

@injectable
@RestApi()
abstract class OrderTrackingApiClient {
  @factoryMethod
  factory OrderTrackingApiClient(Dio dio) = _OrderTrackingApiClient;

  @POST(AppEndPoints.notificationUrl)
  Future<void> sendNotification({
    @Header(Apikeys.authorization) required String authorization,
    @Body() required NotificationRequestModel body,
    }
  );
}
