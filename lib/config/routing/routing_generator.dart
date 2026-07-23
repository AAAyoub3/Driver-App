import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/modules/auth/presentation/screens/email_verification_view.dart';
import 'package:flowery/modules/auth/presentation/screens/forget_password_view.dart';
import 'package:flowery/modules/auth/presentation/screens/on_boarding_screen.dart';
import 'package:flowery/modules/auth/presentation/screens/reset_new_password_view.dart';
import 'package:flowery/modules/auth/presentation/view_models/cubit/forget_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case AppRoutes.onBoarding:
          return MaterialPageRoute(
            builder: (_) => const OnBoardingScreen(),
          );
        case AppRoutes.forgetPassword:
      
        return MaterialPageRoute(
          builder: (_) => const ForgetPasswordView(),
        );

      case AppRoutes.emailVerification:
    
        final cubit = settings.arguments as ForgetPasswordViewModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: cubit,
            child: const EmailVerificationView(),
          ),
        );

      case AppRoutes.resetPassword:
        final cubit = settings.arguments as ForgetPasswordViewModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: cubit,
            child: ResetNewPasswordView(),
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
        appBar: AppBar(
          title: const Text('No Route Found'),
        ),
        body: const Center(
          child: Text('No Route Found'),
        ),
      ),
    );
  }

  static Route<dynamic> errorRoute(String error) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Route Error'),
        ),
        body: Center(
          child: Text(error),
        ),
      ),
    );
  }
}