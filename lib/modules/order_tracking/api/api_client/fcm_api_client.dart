import 'package:dio/dio.dart';
import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/config/api/app_endpoints.dart';
import 'package:flowery/modules/order_tracking/data/models/requests/notification_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'fcm_api_client.g.dart';
@injectable
@RestApi()
abstract class FcmApiClient {
  @factoryMethod
  factory FcmApiClient(@Named(Apikeys.fcm) Dio dio) = _FcmApiClient;

  @POST(AppEndPoints.notificationEndPoint)
  Future<void> sendNotification({
    @Header(Apikeys.authorization) required String authorization,
    @Body() required NotificationRequestModel body,
  });
}
