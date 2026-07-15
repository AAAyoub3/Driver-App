import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/modules/order_tracking/presentation/helpers/order_states_helper.dart';
import 'package:flowery/modules/order_tracking/presentation/keys/order_details_keys.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/cubit/order_details_view_model.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/events/order_details_events.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/states/order_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangingStateButton extends StatelessWidget {
  final AppLocalizations localizations;
  const ChangingStateButton({super.key, required this.localizations});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<OrderDetailsViewModel, OrderDetailsState>(
        buildWhen: (previous, current) {
          return previous.order?.status != current.order?.status ||
              previous.currentOrderState != current.currentOrderState ||
              previous.isUpdatingOrderStatus != current.isUpdatingOrderStatus;
        },
        builder: (context, state) {
          final currentOrderState = getOrderStateFromStatus(
            state.order?.status,
          );
          return ElevatedButton(
            key: Key(OrderDetailsKeys.nextStateButton),
            onPressed: () async {
              if (state.currentOrderState != OrderStates.delivered) {
                final userLocal = await AppLocalizations.delegate.load(
                  Locale(state.userLang),
                );

                context.read<OrderDetailsViewModel>().doEvent(
                  UpdateOrderStateEvent(
                    orderId: state.order?.orderId ?? "",
                    userId: state.order?.userId ?? "",
                    currentOrderState: state.currentOrderState,
                    title: localizations.your_order_status,
                    localizations: localizations,
                    messageSentToUser: state.currentOrderState.buttonText(
                      userLocal,
                    ),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: (currentOrderState?.value ?? 0) < 4
                  ? AppColors.primaryColor
                  : AppColors.hintGrayColor,
            ),
            child: state.isUpdatingOrderStatus
                ? Center(
                    child: SizedBox(
                      height: 15.h,
                      width: 15.w,
                      child: CircularProgressIndicator(
                        color: AppColors.whiteColor,
                      ),
                    ),
                  )
                : Text(
                    currentOrderState?.buttonText(
                          AppLocalizations.of(context)!,
                        ) ??
                        "",
                  ),
          );
        },
      ),
    );
  }
}
