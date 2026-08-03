import 'package:flowery/modules/auth/presentation/view/widgets/login_continue_button.dart';
import 'package:flowery/modules/auth/presentation/view/widgets/login_input_fields.dart';
import 'package:flowery/modules/auth/presentation/view/widgets/login_remember_me_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscure = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24.h),
          LoginEmailField(controller: _emailController),
          SizedBox(height: 16.h),
          StatefulBuilder(
            builder: (context, setPasswordState) => LoginPasswordField(
              controller: _passwordController,
              isObscure: _isObscure,
              onToggle: () =>
                  setPasswordState(() => _isObscure = !_isObscure),
            ),
          ),
          SizedBox(height: 8.h),
          StatefulBuilder(
            builder: (context, setRememberState) => LoginRememberMeRow(
              rememberMe: _rememberMe,
              onChanged: (v) => setRememberState(() => _rememberMe = v),
              onForgetPassword: () {},
            ),
          ),
          SizedBox(height: 32.h),
          LoginContinueButton(
            formKey: _formKey,
            emailController: _emailController,
            passwordController: _passwordController,
            rememberMe: _rememberMe,
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
