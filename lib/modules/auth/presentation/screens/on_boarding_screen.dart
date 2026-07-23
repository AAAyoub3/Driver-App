import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/core/widgets/custom_button.dart';
import 'package:flowery/modules/auth/presentation/screens_assets/on_boarding_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late AppLocalizations localizations;
  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Transform.translate(
              offset: Offset(-25.w, 0),
              child: Lottie.asset(
                OnBoardingAssets.animation,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations.welcome_to,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    localizations.flowery_rider_app,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: 15.h),
                  ElevatedButton(
                    onPressed: () => context.pushNamed(AppRoutes.login),
                    child: Text(localizations.login),
                  ),
                  SizedBox(height: 15.h),
                  CustomButton(
                    onPressed: () => context.pushNamed(AppRoutes.apply),
                    text: localizations.apply,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
