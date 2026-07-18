import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/modules/order_tracking/domain/entities/driver_order_entity.dart';
import 'package:flutter/material.dart';
import 'package:flowery/modules/order_tracking/presentation/widgets/address_tile_widget.dart';
import 'package:flowery/modules/order_tracking/presentation/widgets/order_item_tile_widget.dart';
import 'package:flowery/modules/order_tracking/presentation/widgets/order_status_badge_widget.dart';

class OrderDetailsScreen extends StatelessWidget {
  final DriverOrderEntity driverOrder;

  const OrderDetailsScreen({super.key, required this.driverOrder});

  @override
  Widget build(BuildContext context) {
    final order = driverOrder.order;
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.secondary,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.secondary,
        leading: BackButton(color: theme.colorScheme.onSurface),
        title: Text(
          localizations.order_details,
          style: theme.textTheme.labelLarge?.copyWith(
            decoration: TextDecoration.none,
          ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OrderStatusBadgeWidget(state: order?.state),
              Text(
                order?.orderNumber ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            localizations.pickup_address,
            style: theme.textTheme.labelMedium?.copyWith(
              color: AppColors.grayColor,
              fontSize: 13,
              decoration: TextDecoration.none,
            ),
          ),
          const SizedBox(height: 8),
          AddressTileWidget(
            imageUrl: driverOrder.store?.image,
            name: driverOrder.store?.name ?? '',
            address: driverOrder.store?.address ?? '',
          ),
          const SizedBox(height: 20),
          Text(
            localizations.user_address,
            style: theme.textTheme.labelMedium?.copyWith(
              color: AppColors.grayColor,
              fontSize: 13,
              decoration: TextDecoration.none,
            ),
          ),
          const SizedBox(height: 8),
          AddressTileWidget(
            imageUrl: order?.user?.photo,
            name:
                '${order?.user?.firstName ?? ''} ${order?.user?.lastName ?? ''}',
            address: driverOrder.store?.address ?? '',
          ),
          const SizedBox(height: 20),
          Text(
            localizations.order_details,
            style: theme.textTheme.labelMedium?.copyWith(
              decoration: TextDecoration.none,
            ),
          ),
          const SizedBox(height: 10),
          ...(order?.orderItems ?? []).map(
            (item) => OrderItemTileWidget(item: item),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.lightGrayColor),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  localizations.total,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${localizations.egp} ${order?.totalPrice ?? 0}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.lightGrayColor),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  localizations.payment_method,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  order?.paymentType == localizations.cash
                      ? localizations.cash_on_delivery
                      : (order?.paymentType ?? ''),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}