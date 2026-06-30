import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/core/widgets/custom_text_form_field.dart';
import 'package:flowery/modules/profile/presentation/keys/change_password_screen_keys.dart';
import 'package:flowery/modules/profile/presentation/validators/change_password_validator.dart';
import 'package:flowery/modules/profile/presentation/view_models/cubit/change_password_view_model.dart';
import 'package:flowery/modules/profile/presentation/view_models/events/change_password_events.dart';
import 'package:flowery/modules/profile/presentation/view_models/states/change_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  // Contollers
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  // Form validation key
  final _formKey = GlobalKey<FormState>();
  // Localization
  late AppLocalizations localizations;
  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(localizations.reset_password),
        titleSpacing: 0.0,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              CustomTextFormField(
                key: Key(ChangePasswordScreenKeys.currentPassword),
                hintText: localizations.current_password,
                labelText: localizations.current_password,
                controller: currentPasswordController,
                validator: (value) =>
                    ChangePasswordValidator.validateCurrentPassword(
                      value,
                      localizations,
                    ),
              ),
              SizedBox(height: 10.h),
              CustomTextFormField(
                key: Key(ChangePasswordScreenKeys.newPassword),
                hintText: localizations.new_password,
                labelText: localizations.new_password,
                controller: newPasswordController,
                validator: (value) =>
                    ChangePasswordValidator.validateNewPassword(
                      value,
                      localizations,
                    ),
              ),
              SizedBox(height: 10.h),
              CustomTextFormField(
                key: Key(ChangePasswordScreenKeys.confirmPassword),
                hintText: localizations.confirm_password,
                labelText: localizations.confirm_password,
                controller: confirmPasswordController,
                validator: (value) =>
                    ChangePasswordValidator.validateConfirmPassword(
                      value,
                      newPasswordController.text,
                      localizations,
                    ),
              ),
              SizedBox(height: 30.h),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<ChangePasswordViewModel>().doEvent(
                      UpdatePasswordEvent(
                        password: currentPasswordController.text,
                        newPassword: newPasswordController.text,
                      ),
                    );
                  }
                },
                child:
                    BlocConsumer<ChangePasswordViewModel, ChangePasswordState>(
                      builder: (context, state) {
                        if (state.isLoading == true) {
                          return SizedBox(
                            height: 18.h,
                            width: 18.h,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.whiteColor,
                            ),
                          );
                        }
                        return Text(localizations.update);
                      },
                      listener: (context, state) {
                        if (state.isDone == true) {
                          final snackBarText = SnackBar(
                            content: Text(state.message ?? ""),
                          );
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(snackBarText);
                        }
                      },
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
