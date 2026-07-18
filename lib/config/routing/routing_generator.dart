
import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/modules/order_tracking/presentation/screens/order_tracking_screen.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/cubit/order_details_view_model.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/events/order_details_events.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case AppRoutes.orderDetails:
          return MaterialPageRoute(
            builder: (context) {
              final localizations = AppLocalizations.of(context)!;

              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (_) => getIt<OrderDetailsViewModel>()
                      ..doEvent(
                        GetOrderDetailsEvent(
                          "6a3845ab992612ae599b1736",
                          localizations,
                        ),
                      ),
                  ),
                ],
                child: const OrderDetailsScreen(),
              );
            },
          );

        default:
          return unDefinedRoute();
      }
    } catch (e) {
      return errorRoute(e.toString());
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('No Route Found')),
        body: const Center(child: Text('No Route Found')),
        appBar: AppBar(title: const Text('No Route Found')),
        body: const Center(child: Text('No Route Found')),
      ),
    );
  }

  static Route<dynamic> errorRoute(String error) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Route Error')),
        body: Center(child: Text(error)),
        appBar: AppBar(title: const Text('Route Error')),
        body: Center(child: Text(error)),
      ),
    );
  }
}

