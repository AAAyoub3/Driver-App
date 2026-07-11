import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/modules/profile/presentation/screens/change_password_screen.dart';
import 'package:flowery/modules/profile/presentation/screens/my_profile_screen.dart';
import 'package:flowery/modules/profile/presentation/view_models/cubit/change_password_view_model.dart';
import 'package:flowery/modules/profile/presentation/view_models/cubit/my_profiel_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case AppRoutes.changePassword:
          return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: ((context) => getIt<ChangePasswordViewModel>()),
                ),
              ],
              child: const ChangePasswordScreen(),
            ),
          );
        case AppRoutes.myProfile:
          return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: ((context) => getIt<MyProfielViewModel>()),
                ),
              ],
              child: MyProfileScreen(),
            ),
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
