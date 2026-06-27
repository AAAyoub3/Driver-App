import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/order_tracking/data/model/home_response_models/home_respnose_model.dart';

abstract class OrderTrackingRemoteDataSourcesContract {
  Future<Result<HomeResponseModel>> getHomeData({int page = 1});


}
