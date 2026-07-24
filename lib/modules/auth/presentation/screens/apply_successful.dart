import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/core/app_assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplySuccessful extends StatefulWidget {
  const ApplySuccessful({super.key});

  @override
  State<ApplySuccessful> createState() => _ApplySuccessfulState();
}

class _ApplySuccessfulState extends State<ApplySuccessful> {
  late AppLocalizations localizations;
  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(Assets.pngBack, fit: BoxFit.fitWidth),
          ),
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(Assets.pngSuccess, fit: BoxFit.cover),
                SizedBox(height: 20.h),
                Text(
                  localizations.yourApplicationHasBeenSubmitted,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: .w600,
                    fontSize: 18.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                Text(
                  localizations.thankyouForProvidingApplication,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: .w400,
                    fontSize: 16.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: 300.w,
                  child: ElevatedButton(
                    onPressed: () {
                      context.pushNamed(AppRoutes.login);
                    },
                    child: Text(localizations.login),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
