import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/modules/order_tracking/presentation/helpers/order_states_helper.dart';
import 'package:flowery/modules/order_tracking/presentation/keys/order_details_keys.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/cubit/order_details_view_model.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/states/order_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProgressBar extends StatelessWidget {
  const CustomProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<OrderDetailsViewModel, OrderDetailsState>(
            buildWhen: (previous, current) =>
                previous.isLoadingOrder != current.isLoadingOrder ||
                previous.order?.status != current.order?.status,
            builder: (context, state) {
              final currentOrderState = getOrderStateFromStatus(
                state.order?.status,
              );
              if (state.isLoadingOrder) {
                return const SizedBox.shrink();
              }
              return Container(
                key: Key('${OrderDetailsKeys.progress}$index'),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: index <= (currentOrderState?.value ?? 0)
                      ? AppColors.greenColor
                      : AppColors.grayColor,
                ),
                child: SizedBox(height: 3.h, width: 50.w),
              );
            },
          ),
        );
      }),
    );
  }
}
