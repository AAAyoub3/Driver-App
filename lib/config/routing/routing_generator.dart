import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/modules/auth/presentation/screens/apply_screen.dart';
import 'package:flowery/modules/auth/presentation/screens/apply_successful.dart';
import 'package:flowery/modules/auth/presentation/view_model/cubit/apply_cubit.dart';
import 'package:flowery/modules/auth/presentation/view_model/events/apply_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case AppRoutes.apply:
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => getIt<ApplyCubit>()
                ..doEvent(GetCountriesEvent())
                ..doEvent(GetVehiclesEvent()),
              child: ApplyScreen(),
            ),
          );

        case AppRoutes.applySuccess:
          return MaterialPageRoute(builder: (_) => ApplySuccessful());

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
      ),
    );
  }

  static Route<dynamic> errorRoute(String error) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Route Error')),
        body: Center(child: Text(error)),
      ),
    );
  }
}
