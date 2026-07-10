import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/cubit/home_view_model.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/events/home_event.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/states/home_state.dart';
import 'package:flowery/modules/order_tracking/presentation/widgets/order_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flowery rider',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: BlocConsumer<HomeViewModel, HomeState>(
        listenWhen: (prev, curr) => curr.acceptErrorMessage != null,
        listener: (context, state) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.acceptErrorMessage!),
              backgroundColor: AppColors.redColor,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return state.ordersState.when(
            initial: () => const SizedBox(),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e) => Center(
              child: Text(
                e.toString(),
                style: TextStyle(fontSize: 14.sp, color: AppColors.redColor),
              ),
            ),
            success: (data) {
              final orders = data.orders ?? [];
              if (orders.isEmpty) {
                return Center(
                  child: Text(
                    'No orders available',
                    style: TextStyle(fontSize: 14.sp, color: AppColors.grayColor),
                  ),
                );
              }
              return RefreshIndicator(
                color: AppColors.primaryColor,
                onRefresh: () async =>
                    context.read<HomeViewModel>().doEvent(GetOrdersEvent()),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  itemCount: orders.length,
                  itemBuilder: (context, index) => OrderCardWidget(
                    order: orders[index],
                    onReject: () => context.read<HomeViewModel>().doEvent(
                          RejectOrderEvent(orderId: orders[index].orderId ?? ''),
                        ),
                    onAccept: () => context.read<HomeViewModel>().doEvent(
                          AcceptOrderEvent(order: orders[index]),
                        ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
