import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flowery/modules/order_tracking/domain/entities/driver_orders_response_entity.dart';

class OrderItemTileWidget extends StatelessWidget {
  final OrderItemEntity item;

  const OrderItemTileWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightGrayColor),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.local_florist, color: Colors.grey),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${localizations.product} #${item.product?.id ?? ''}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelMedium?.copyWith(
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${localizations.egp} ${item.price ?? 0}',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
          Text(
            'X${item.quantity ?? 0}',
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.error,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
