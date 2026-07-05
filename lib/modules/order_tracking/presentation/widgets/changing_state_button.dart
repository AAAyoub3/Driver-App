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
        builder: (context, state) {
          final currentOrderState = getOrderStateFromStatus(
            state.order?.status,
          );
          return ElevatedButton(
            key: Key(OrderDetailsKeys.nextStateButton),
            onPressed: () {
              if (state.currentOrderState != OrderStates.fifthState) {
                context.read<OrderDetailsViewModel>().doEvent(
                  UpdateOrderStateEvent(
                    orderId: state.order?.orderId ?? "",
                    userId: state.order?.userId ?? "",
                    currentOrderState: state.currentOrderState,
                    title: localizations.your_order_status,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: (currentOrderState?.value ?? 0) < 4
                  ? AppColors.primaryColor
                  : AppColors.hintGrayColor,
            ),
            child: BlocBuilder<OrderDetailsViewModel, OrderDetailsState>(
              builder: (context, state) {
                if (state.isUpdatingOrderStatus) {
                  return Center(
                    child: SizedBox(
                      height: 15.h,
                      width: 15.w,
                      child: CircularProgressIndicator(
                        color: AppColors.whiteColor,
                      ),
                    ),
                  );
                }
                return Text(currentOrderState?.buttonText ?? "");
              },
            ),
          );
        },
      ),
    );
  }
}
