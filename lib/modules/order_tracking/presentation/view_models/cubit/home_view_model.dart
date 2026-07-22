import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/core/services/location_service.dart';
import 'package:flowery/modules/order_tracking/domain/entity/home_entity/order_entity.dart';
import 'package:flowery/modules/order_tracking/domain/entity/home_entity/paginated_orders_entity.dart';
import 'package:flowery/modules/order_tracking/domain/use_case/accept_order_use_case.dart';
import 'package:flowery/modules/order_tracking/domain/use_case/get_orders_use_case.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/events/home_event.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/states/home_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeViewModel extends Cubit<HomeState> {
  final GetOrdersUseCase _getOrdersUseCase;
  final AcceptOrderUseCase _acceptOrderUseCase;
  final LocationService _locationService;
  final Set<String> _rejectedIds = {};

  HomeViewModel(
    this._getOrdersUseCase,
    this._acceptOrderUseCase,
    this._locationService,
  ) : super(HomeState()) {
    doEvent(GetOrdersEvent());
  }

  void doEvent(HomeEvent event) {
    switch (event) {
      case GetOrdersEvent():
        _getOrders(event.page);
      case RejectOrderEvent():
        _rejectOrder(event.orderId);
      case AcceptOrderEvent():
        _acceptOrder(event.order);
    }
  }

  Future<void> _getOrders(int page) async {
    if (page == 1) _rejectedIds.clear();
    emit(state.copyWith(isLoading: true));

    final response = await _getOrdersUseCase(page: page);
    switch (response) {
      case Success<PaginatedOrdersEntity>():
        emit(state.copyWith(
          isLoading: false,
          ordersState: BaseState.success(response.data),
        ));
      case Error<PaginatedOrdersEntity>(:final exception):
        emit(state.copyWith(
          isLoading: false,
          ordersState: BaseState.error(exception!),
        ));
    }
  }

  void _rejectOrder(String orderId) {
    _rejectedIds.add(orderId);
    state.ordersState.when(
      initial: () {},
      loading: () {},
      error: (_) {},
      success: (data) {
        final filtered = (data.orders ?? [])
            .where((o) => !_rejectedIds.contains(o.orderId))
            .toList();
        emit(state.copyWith(
          ordersState: BaseState.success(
            PaginatedOrdersEntity(
              orders: filtered,
              currentPage: data.currentPage,
              totalPages: data.totalPages,
              hasMore: data.hasMore,
            ),
          ),
        ));
      },
    );
  }

  Future<void> _acceptOrder(OrderEntity order) async {
    emit(state.copyWith(isLoading: true));
    final response = await _acceptOrderUseCase(order);
    switch (response) {
      case Success<String>():
        emit(state.copyWith(isLoading: false));
        final driverId = response.data ?? '';
        if (driverId.isNotEmpty) {
          _locationService.startTracking(driverId);
        }
      case Error<String>():
        emit(state.copyWith(
          isLoading: false,
          acceptErrorMessage: 'Sorry, we couldn\'t accept this order. Please try again.',
        ));
    }
  }
}
