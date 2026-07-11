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
        return const Color(0xFF1FAE59);
      case OrderTrackingStatus.cancelled:
        return const Color(0xFFE9384D);
      case OrderTrackingStatus.pending:
        return const Color(0xFFF5A623);
      case OrderTrackingStatus.unknown:
        return Colors.grey;
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
