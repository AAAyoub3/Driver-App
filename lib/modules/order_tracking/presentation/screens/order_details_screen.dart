import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/modules/order_tracking/presentation/keys/order_details_keys.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/cubit/order_details_view_model.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/events/order_details_events.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/states/order_details_state.dart';
import 'package:flowery/modules/order_tracking/presentation/widgets/custom_address_container.dart';
import 'package:flowery/modules/order_tracking/presentation/widgets/custom_order_container.dart';
import 'package:flowery/modules/order_tracking/presentation/widgets/custom_payment_container.dart';
import 'package:flowery/modules/order_tracking/presentation/widgets/status_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum OrderStates {
  firstState(
    buttonText: "Arrived at Pickup point",
    statusText: "Accepted",
    value: 0,
  ),
  secondState(buttonText: "Start deliver", statusText: "Picked", value: 1),
  thirdState(
    buttonText: "Arrived to the user",
    statusText: "Out for delivery",
    value: 2,
  ),
  fourthState(
    buttonText: "Delivered to the user",
    statusText: "Arrived",
    value: 3,
  ),
  fifthState(
    buttonText: "Delivered to the user",
    statusText: "Delivered",
    value: 4,
  );

  final String buttonText;
  final String statusText;
  final int value;

  const OrderStates({
    required this.buttonText,
    required this.statusText,
    required this.value,
  });
}

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  // Order ID and Date
  final String orderId = "#123456";
  final String date = "Wed, 03 Sep 2024, 11:00 AM ";

  // Pickup Address container
  final String storeIcon =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsxcy_ckU8H5X-vxojaIRZj1ZH50YdflNScXh4RkrNNAVVWwx8RyZD79s&s=10";
  final String storeTitle = "Flowery Store";
  final String storeAddress = "20th st, Sheikh Zayed, Giza ";

  // User Address container
  final String userIcon =
      "https://img.magnific.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg?semt=ais_hybrid&w=740&q=80";
  final String userTitle = "Abdelrahman Ayoub";
  final String userAddress = "7th st, Smouha, Alexandria ";

  // Order container
  final String itemIcon =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsuD0O9o_IRPuy0VDg5VJ0jjw9FsuMHwByfYNyZtEM1A&s=10";
  final String itemTitle = "Red roses,15 Pink Rose Bouquet";
  final String itemCost = "500";
  final String itemNumber = "2";

  // Payment Container
  final String orderCost = "1000";
  final String paymentMethod = "Cash on delivery";

  // Localization
  late AppLocalizations localizations;

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(localizations.order_details),
        titleSpacing: 0.0,
        bottom: PreferredSize(
          preferredSize: Size(0, 20.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<OrderDetailsViewModel, OrderDetailsState>(
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
          ),
        ),
      ),
      body: BlocBuilder<OrderDetailsViewModel, OrderDetailsState>(
        builder: (context, state) {
          if (state.isLoadingOrder) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder<OrderDetailsViewModel, OrderDetailsState>(
                  builder: (context, state) => StatusContainer(
                    status: state.order?.status ?? "",
                    orderId: state.order?.orderId ?? "",
                    date: state.order?.acceptedAt ?? "",
                  ),
                ),

                // Pick Up Address
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        localizations.pick_up_address,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomAddressContainer(
                    icon: state.order?.storeImage ?? "",
                    title: state.order?.storeName ?? "",
                    address: state.order?.storeAddress ?? "",
                  ),
                ),
                SizedBox(height: 10.h),

                // User Address
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        localizations.user_address,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomAddressContainer(
                    icon: state.order?.userPhoto ?? "",
                    title: state.order?.userName ?? "",
                    address: state.order?.userAddress ?? "",
                  ),
                ),
                SizedBox(height: 10.h),

                // Order Details
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        localizations.order_details,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                CustomOrderContainer(
                  icon: itemIcon,
                  title: itemTitle,
                  cost: itemCost,
                  numberOfItem: itemNumber,
                ),
                SizedBox(height: 10.h),

                // Payment Details
                CustomPaymentContainer(
                  title: localizations.total,
                  value:
                      "${state.order?.totalPrice ?? ""} ${localizations.egp}",
                ),
                SizedBox(height: 10.h),
                CustomPaymentContainer(
                  title: localizations.payment_method,
                  value: paymentMethod,
                ),
                SizedBox(height: 20.h),

                // Changing state button
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: BlocBuilder<OrderDetailsViewModel, OrderDetailsState>(
                    builder: (context, state) {
                      final currentOrderState = getOrderStateFromStatus(
                        state.order?.status,
                      );
                      return ElevatedButton(
                        key: Key(OrderDetailsKeys.nextStateButton),
                        onPressed: () {
                          context.read<OrderDetailsViewModel>().doEvent(
                            NextOrderStateEvent(
                              orderId: state.order?.orderId ?? "",
                              currentOrderState: state.currentOrderState,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: (currentOrderState?.value ?? 0) < 4
                              ? AppColors.primaryColor
                              : AppColors.hintGrayColor,
                        ),
                        child: Text(currentOrderState?.buttonText ?? ""),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          );
        },
      ),
    );
  }
}

OrderStates? getOrderStateFromStatus(String? status) {
  if (status == null) return null;

  return OrderStates.values.firstWhere(
    (e) => e.statusText == status,
    orElse: () => OrderStates.firstState,
  );
}
