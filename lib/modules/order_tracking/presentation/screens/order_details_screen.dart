import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/cubit/order_details_view_model.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/states/order_details_state.dart';
import 'package:flowery/modules/order_tracking/presentation/widgets/changing_state_button.dart';
import 'package:flowery/modules/order_tracking/presentation/widgets/containers/custom_address_container.dart';
import 'package:flowery/modules/order_tracking/presentation/widgets/containers/custom_order_container.dart';
import 'package:flowery/modules/order_tracking/presentation/widgets/containers/custom_payment_container.dart';
import 'package:flowery/modules/order_tracking/presentation/widgets/custom_progress_bar.dart';
import 'package:flowery/modules/order_tracking/presentation/widgets/custom_title.dart';
import 'package:flowery/modules/order_tracking/presentation/widgets/containers/status_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
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
          child: CustomProgressBar(),
        ),
      ),
      body: BlocConsumer<OrderDetailsViewModel, OrderDetailsState>(
        buildWhen: (previous, current) {
          return previous.isLoadingOrder != current.isLoadingOrder ||
              previous.order != current.order;
        },
        listenWhen: (previous, current) {
          return previous.errorMessage != current.errorMessage;
        },
        builder: (context, state) {
          if (state.isLoadingOrder) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Status Container
                      StatusContainer(
                        status: state.order?.status ?? "",
                        orderId: state.order?.orderNumber ?? "",
                        date: state.order?.acceptedAt ?? "",
                      ),

                      // Pick Up Address
                      CustomTitle(title: localizations.pick_up_address),
                      CustomAddressContainer(
                        icon: state.order?.storeImage ?? "",
                        title: state.order?.storeName ?? "",
                        address: state.order?.storeAddress ?? "",
                      ),
                      SizedBox(height: 10.h),

                      // User Address
                      CustomTitle(title: localizations.user_address),
                      CustomAddressContainer(
                        icon: state.order?.userPhoto ?? "",
                        title: state.order?.userName ?? "",
                        address: state.order?.userAddress ?? "",
                      ),
                      SizedBox(height: 10.h),

                      // Order Details
                      CustomTitle(title: localizations.order_details),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.order?.items?.length ?? 0,
                        itemBuilder: (context, index) {
                          final item = state.order?.items?[index];
                          return CustomOrderContainer(
                            icon: item?.itemIcon ?? "",
                            title: item?.itemTitle ?? "",
                            cost: item?.itemCost ?? "",
                            numberOfItem: item?.itemCount ?? "",
                          );
                        },
                      ),

                      // Payment Details
                      CustomPaymentContainer(
                        title: localizations.total,
                        value:
                            "${state.order?.totalPrice ?? ""} ${localizations.egp}",
                      ),
                      SizedBox(height: 10.h),
                      CustomPaymentContainer(
                        title: localizations.payment_method,
                        value: state.order?.paymentMethod ?? "",
                      ),
                    ],
                  ),
                ),
              ),
              // Changing state button
              ChangingStateButton(localizations: localizations),
            ],
          );
        },
        listener: (context, state) {
          if (state.errorMessage != "" && state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage ?? "")));
          }
        },
      ),
    );
  }
}
