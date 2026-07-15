import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/modules/order_tracking/presentation/helpers/order_states_helper.dart';

sealed class OrderDetailsEvents {}

class UpdateOrderStateEvent extends OrderDetailsEvents {
  final String messageSentToUser;
  final String orderId;
  final String userId;
  final OrderStates currentOrderState;
  final String title;
  final AppLocalizations localizations;
  UpdateOrderStateEvent({
    required this.orderId,
    required this.userId,
    required this.currentOrderState,
    required this.title,
    required this.localizations,
    required this.messageSentToUser,
  });
}

class GetOrderDetailsEvent extends OrderDetailsEvents {
  final String driverId;
  final AppLocalizations localizations;
  GetOrderDetailsEvent(this.driverId, this.localizations);
}

class GetUserLanguageEvent extends OrderDetailsEvents {
  final String userId;

  GetUserLanguageEvent({required this.userId});
}
