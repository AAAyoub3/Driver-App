import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/modules/profile/presentation/screens/change_password_screen.dart';
import 'package:flowery/modules/profile/presentation/screens/edit_profile_screen.dart';
import 'package:flowery/modules/profile/presentation/view_models/cubit/change_password_view_model.dart';
import 'package:flowery/modules/profile/presentation/view_models/cubit/edit_profile_view_model.dart';
import 'package:flowery/modules/profile/presentation/view_models/cubit/uplaod_profile_photo_view_model.dart';
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
        case AppRoutes.editProfile:
          
          return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<EditProfileViewModel>(),
                ),
                BlocProvider(
                  create: (context) => getIt<UplaodProfilePhotoViewModel>(),
                ),
              ],
              child: const EditProfileScreen(
                firstName: 'Ahmed',
                lastName: 'Tech3',
                email: 'abdelrahmanobo12@gmail.com',
                phone: '+201010700888',
                gender: 'male',
                photo:
                    'https://flower.elevateegy.com/uploads/19cb6be2-2cf3-4ce0-9af8-d62658b381c1-5x-5.jpg',
              ),
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
