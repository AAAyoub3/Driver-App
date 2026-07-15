import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

enum OrderTrackingStatus { pending, completed, cancelled, unknown }

extension OrderStateX on String? {
  OrderTrackingStatus get orderStatus {
    switch (this) {
      case 'completed':
      case 'delivered':
        return OrderTrackingStatus.completed;
      case 'cancelled':
        return OrderTrackingStatus.cancelled;
      case 'pending':
        return OrderTrackingStatus.pending;
      default:
        return OrderTrackingStatus.unknown;
    }
  }
}

extension OrderTrackingStatusX on OrderTrackingStatus {
  String get label {
    switch (this) {
      case OrderTrackingStatus.completed:
        return 'Completed';
      case OrderTrackingStatus.cancelled:
        return 'Cancelled';
      case OrderTrackingStatus.pending:
        return 'Pending';
      case OrderTrackingStatus.unknown:
        return 'Unknown';
    }
  }

  Color get color {
    switch (this) {
      case OrderTrackingStatus.completed:
        return AppColors.greenColor;
      case OrderTrackingStatus.cancelled:
        return AppColors.redColor;
      case OrderTrackingStatus.pending:
        return AppColors.primaryColor;
      case OrderTrackingStatus.unknown:
        return AppColors.grayColor;
    }
  }

  IconData get icon {
    switch (this) {
      case OrderTrackingStatus.completed:
        return Icons.check_circle;
      case OrderTrackingStatus.cancelled:
        return Icons.cancel;
      case OrderTrackingStatus.pending:
        return Icons.access_time_filled;
      case OrderTrackingStatus.unknown:
        return Icons.help;
    }
  }
}
