import 'package:flowery/modules/order_tracking/data/data_sources/profile_remote_data_sources_contract.dart';
import 'package:flowery/modules/order_tracking/domain/repo/profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrderTrackingRepoContract)
class OrderTrackingRepoImpl extends OrderTrackingRepoContract {
  final OrderTrackingRemoteDataSourcesContract remoteDataSources;
  OrderTrackingRepoImpl(this.remoteDataSources);
}
