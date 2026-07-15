import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'order_tracking_api_client.g.dart';

@injectable
@RestApi()
abstract class OrderTrackingApiClient {}
