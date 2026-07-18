import 'package:flutter/material.dart';
import 'package:flowery/modules/order_tracking/presentation/utils/order_status_x.dart';

class OrderStatusBadgeWidget extends StatelessWidget {
  final String? state;

  const OrderStatusBadgeWidget({super.key, this.state});

  @override
  Widget build(BuildContext context) {
    final status = state.orderStatus;
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(status.icon, color: status.color, size: 18),
        const SizedBox(width: 6),
        Text(
          status.label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: status.color,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            decoration: TextDecoration.none
          ),
        ),
      ],
    );
  }
}
