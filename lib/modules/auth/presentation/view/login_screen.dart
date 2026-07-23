import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/modules/auth/presentation/view/widgets/login_body.dart';
import 'package:flowery/modules/auth/presentation/view_model/cubit.dart';
import 'package:flowery/modules/auth/presentation/view_model/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (_) => getIt<LoginCubit>(),
      child: Builder(
        builder: (context) {
          final loginCubit = context.read<LoginCubit>();
          return BlocListener<LoginCubit, LoginStates>(
            listener: (context, state) {
              state.loginState.when(
                initial: () {},
                loading: () {},
                success: (data) {
                  // TODO: navigate to home
                },
                error: (exception) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(exception.toString()),
                      backgroundColor: AppColors.redColor,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              );
            },
            child: Scaffold(
              backgroundColor: AppColors.whiteColor,
              appBar: AppBar(
                backgroundColor: AppColors.whiteColor,
                elevation: 0,
                scrolledUnderElevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.blackColor,
                    size: 20.sp,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                titleSpacing: 0,
                title: Text(
                  AppLocalizations.of(context)!.login,
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: SingleChildScrollView(
                    child: LoginBody(loginCubit: loginCubit),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
