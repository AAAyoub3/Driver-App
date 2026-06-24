import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'order_tracking_api_client.g.dart';

@injectable
@RestApi()
abstract class OrderTrackingApiClient {
  @factoryMethod
  factory OrderTrackingApiClient(Dio dio) = _OrderTrackingApiClient;

  // @GET('/tasks')
  // Future<List<Task>> getTasks();
}