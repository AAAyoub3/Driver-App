import 'package:flowery/config/l10n/translations/app_localizations.dart';

enum OrderStates {
  accepted(
    buttonTextKey: 'arrived_at_pickup_point',
    statusTextKey: 'accepted',
    value: 0,
  ),
  picked(buttonTextKey: 'start_deliver', statusTextKey: 'picked', value: 1),
  outForDelivery(
    buttonTextKey: 'arrived_to_the_user',
    statusTextKey: 'out_for_delivery',
    value: 2,
  ),
  arrived(
    buttonTextKey: 'delivered_to_the_user',
    statusTextKey: 'arrived',
    value: 3,
  ),
  delivered(
    buttonTextKey: 'delivered_to_the_user',
    statusTextKey: 'delivered',
    value: 4,
  );

  final String buttonTextKey;
  final String statusTextKey;
  final int value;

  const OrderStates({
    required this.buttonTextKey,
    required this.statusTextKey,
    required this.value,
  });
}

extension OrderStatesLocalization on OrderStates {
  String buttonText(AppLocalizations l10n) {
    switch (this) {
      case OrderStates.accepted:
        return l10n.arrived_at_pickup_point;
      case OrderStates.picked:
        return l10n.start_deliver;
      case OrderStates.outForDelivery:
        return l10n.arrived_to_the_user;
      case OrderStates.arrived:
      case OrderStates.delivered:
        return l10n.delivered_to_the_user;
    }
  }

  String statusText(AppLocalizations l10n) {
    switch (this) {
      case OrderStates.accepted:
        return l10n.accepted;
      case OrderStates.picked:
        return l10n.picked;
      case OrderStates.outForDelivery:
        return l10n.out_for_delivery;
      case OrderStates.arrived:
        return l10n.arrived;
      case OrderStates.delivered:
        return l10n.delivered;
    }
  }
}

OrderStates? getOrderStateFromStatus(String? status) {
  if (status == null) return null;

  return OrderStates.values.firstWhere(
    (state) => state.statusTextKey == status,
    orElse: () => OrderStates.accepted,
  );
}
