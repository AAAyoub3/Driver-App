import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/modules/order_tracking/domain/entities/driver_order_entity.dart';
import 'package:flowery/modules/order_tracking/presentation/screens/order_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flowery/modules/order_tracking/presentation/widgets/address_tile_widget.dart';
import 'package:flowery/modules/order_tracking/presentation/widgets/order_status_badge_widget.dart';

class OrderCardWidget extends StatelessWidget {
  final DriverOrderEntity driverOrder;

  const OrderCardWidget({super.key, required this.driverOrder});

  @override
  Widget build(BuildContext context) {
    final order = driverOrder.order;
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OrderDetailsScreen(driverOrder: driverOrder),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grayColor),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.flower_order,
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                decoration: TextDecoration.none
              ),
            ),
            const SizedBox(height: 8),
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
            const SizedBox(height: 12),
            Text(
              localizations.pickup_address,
              style: theme.textTheme.labelMedium?.copyWith(
                color: Colors.grey.shade600,
                fontSize: 12,
                decoration: TextDecoration.none
              ),
            ),
            const SizedBox(height: 6),
            AddressTileWidget(
              imageUrl: driverOrder.store?.image,
              name: driverOrder.store?.name ?? '',
              address: driverOrder.store?.address ?? '',
            ),
            const SizedBox(height: 10),
            Text(
              localizations.user_address,
              style: theme.textTheme.labelMedium?.copyWith(
                color: Colors.grey.shade600,
                fontSize: 12,
                decoration: TextDecoration.none
              ),
            ),
            const SizedBox(height: 6),
            AddressTileWidget(
              imageUrl: order?.user?.photo,
              name:
                  '${order?.user?.firstName ?? ''} ${order?.user?.lastName ?? ''}',
              address: driverOrder.store?.address ?? '',
            ),
          ],
        ),
      ),
    );
  }
}
