// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../core/services/location_service.dart' as _i752;
import '../../modules/order_tracking/api/api_client/order_tracking_api_client.dart'
    as _i543;
import '../../modules/order_tracking/api/data_sources/order_tracking_remote_data_sources_impl.dart'
    as _i708;
import '../../modules/order_tracking/data/data_sources/firestore_data_source.dart'
    as _i2;
import '../../modules/order_tracking/data/data_sources/orders_remote_data_sources_contract.dart'
    as _i489;
import '../../modules/order_tracking/data/repo/profile_repo_impl.dart' as _i119;
import '../../modules/order_tracking/domain/repo/profile_repo_contract.dart'
    as _i331;
import '../../modules/order_tracking/domain/use_case/accept_order_use_case.dart'
    as _i812;
import '../../modules/order_tracking/domain/use_case/get_orders_use_case.dart'
    as _i717;
import '../../modules/order_tracking/presentation/view_models/cubit/home_view_model.dart'
    as _i286;
import '../api/app_interceptors.dart' as _i781;
import '../general_cubit/local_cubit.dart' as _i794;
import '../helpers/shared_pref.dart' as _i42;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final coreInjectableModule = _$CoreInjectableModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => coreInjectableModule.prefs(),
      preResolve: true,
    );
    gh.singleton<_i361.Dio>(() => coreInjectableModule.dio());
    gh.singleton<_i2.FirestoreDataSource>(() => _i2.FirestoreDataSource());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => coreInjectableModule.secureStorage(),
    );
    gh.lazySingleton<_i361.CancelToken>(
      () => coreInjectableModule.cancelToken(),
    );
    gh.lazySingleton<_i161.InternetConnection>(
      () => coreInjectableModule.internetConnection(),
    );
    gh.factory<_i42.SharedPrefHelper>(
      () => _i42.SharedPrefHelper(gh<_i460.SharedPreferences>()),
    );
    gh.singleton<_i752.LocationService>(
      () => _i752.LocationService(gh<_i2.FirestoreDataSource>()),
    );
    gh.factory<_i543.OrderTrackingApiClient>(
      () => _i543.OrderTrackingApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i489.OrderTrackingRemoteDataSourcesContract>(
      () => _i708.OrderTrackingRemoteDataSourcesImpl(
        gh<_i543.OrderTrackingApiClient>(),
      ),
    );
    gh.singleton<_i781.AuthInterceptor>(
      () => _i781.AuthInterceptor(
        dio: gh<_i361.Dio>(),
        fss: gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.factory<_i794.LocaleThemeCubit>(
      () => _i794.LocaleThemeCubit(gh<_i42.SharedPrefHelper>()),
    );
    gh.factory<_i331.OrderTrackingRepoContract>(
      () => _i119.OrderTrackingRepoImpl(
        gh<_i489.OrderTrackingRemoteDataSourcesContract>(),
        gh<_i2.FirestoreDataSource>(),
      ),
    );
    gh.factory<_i812.AcceptOrderUseCase>(
      () => _i812.AcceptOrderUseCase(gh<_i331.OrderTrackingRepoContract>()),
    );
    gh.factory<_i717.GetOrdersUseCase>(
      () => _i717.GetOrdersUseCase(gh<_i331.OrderTrackingRepoContract>()),
    );
    gh.factory<_i286.HomeViewModel>(
      () => _i286.HomeViewModel(
        gh<_i717.GetOrdersUseCase>(),
        gh<_i812.AcceptOrderUseCase>(),
        gh<_i752.LocationService>(),
      ),
    );
    return this;
  }
}

class _$CoreInjectableModule extends _i291.CoreInjectableModule {}
