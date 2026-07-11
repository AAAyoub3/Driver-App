import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/modules/order_tracking/presentation/view_model/base_state/order_tracking_state.dart';
import 'package:flowery/modules/order_tracking/presentation/view_model/cubit/order_tracking_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowery/modules/order_tracking/presentation/view_model/events/order_tracking_events.dart';
import 'package:flowery/modules/order_tracking/presentation/widgets/order_card_widget.dart';
import 'package:flowery/modules/order_tracking/presentation/widgets/order_stat_card_widget.dart';

class OrdersListScreen extends StatelessWidget {
  const OrdersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return BlocProvider(
      create: (_) => getIt<OrderTrackingViewModel>()..doEvent(GetOrdersEvent()),
      child: Scaffold(
        backgroundColor: theme.colorScheme.secondary,
        appBar: AppBar(
          backgroundColor: theme.colorScheme.secondary,
          leading: BackButton(color: theme.colorScheme.onSurface),
          title: Text(
            localizations.my_orders,
            style: theme.textTheme.labelLarge,
          ),
          centerTitle: false,
          elevation: 0,
        ),
        body: BlocBuilder<OrderTrackingViewModel, OrderTrackingState>(
          builder: (context, state) {
            if (state.isLoadingOrders && state.orders.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.errorMessage != null && state.orders.isEmpty) {
              return Center(child: Text(state.errorMessage!));
            }

            final orders = state.orders;
            final cancelledCount = orders
                .where((o) => o.order?.state == 'cancelled')
                .length;
            final completedCount = orders
                .where((o) => o.order?.state == 'completed')
                .length;

            return RefreshIndicator(
              onRefresh: () async => context
                  .read<OrderTrackingViewModel>()
                  .doEvent(GetOrdersEvent()),
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: OrderStatCardWidget(
                          count: cancelledCount,
                          label: localizations.cancelled,
                          icon: Icons.cancel,
                          color: theme.colorScheme.error,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OrderStatCardWidget(
                          count: completedCount,
                          label: localizations.complete,
                          icon: Icons.check_circle,
                          color: AppColors.greenColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    localizations.recent_orders,
                    style: theme.textTheme.labelMedium!.copyWith(decoration: TextDecoration.none),
                  ),
                  const SizedBox(height: 12),
                  ...orders.map((o) => OrderCardWidget(driverOrder: o)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
