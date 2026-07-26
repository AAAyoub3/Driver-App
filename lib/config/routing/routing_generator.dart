import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/modules/auth/presentation/screens/email_verification_view.dart';
import 'package:flowery/modules/auth/presentation/screens/forget_password_view.dart';
import 'package:flowery/modules/auth/presentation/screens/reset_new_password_view.dart';
import 'package:flowery/modules/auth/presentation/view_models/cubit/forget_password_view_model.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/modules/thanks_page_feature/screens/thanks_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flowery/modules/app_section/screens/app_section_screen.dart';
import 'package:flowery/modules/app_section/view_model/app_section_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        // case AppRoutes.login:
        //   return MaterialPageRoute(
        //     builder: (_) => const LoginScreen(),
        //   );
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
        case AppRoutes.thanksPage:
          return MaterialPageRoute(builder: (_) => const ThanksPageScreen());
        case AppRoutes.appSection:
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => AppSectionViewModel(),
              child: const AppSectionScreen(),
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
