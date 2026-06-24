import 'package:flowery/modules/order_tracking/api/api_client/order_tracking_api_client.dart';
import 'package:flowery/modules/order_tracking/data/data_sources/profile_remote_data_sources_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrderTrackingRemoteDataSourcesContract)
class OrderTrackingRemoteDataSourcesImpl
    extends OrderTrackingRemoteDataSourcesContract {
  final OrderTrackingApiClient apiClient;
  OrderTrackingRemoteDataSourcesImpl(this.apiClient);
}
