import 'package:flowery/modules/auth/presentation/view/widgets/login_continue_button.dart';
import 'package:flowery/modules/auth/presentation/view/widgets/login_input_fields.dart';
import 'package:flowery/modules/auth/presentation/view/widgets/login_remember_me_row.dart';
import 'package:flowery/modules/auth/presentation/view_model/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key, required this.loginCubit});
  final LoginCubit loginCubit;

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  bool _isObscure = true;
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.loginCubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24.h),
          LoginEmailField(controller: widget.loginCubit.emailController),
          SizedBox(height: 16.h),
          LoginPasswordField(
            controller: widget.loginCubit.passwordController,
            isObscure: _isObscure,
            onToggle: () => setState(() => _isObscure = !_isObscure),
          ),
          SizedBox(height: 8.h),
          LoginRememberMeRow(
            rememberMe: _rememberMe,
            onChanged: (v) => setState(() => _rememberMe = v),
            onForgetPassword: () {},
          ),
          SizedBox(height: 32.h),
          LoginContinueButton(loginCubit: widget.loginCubit),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
