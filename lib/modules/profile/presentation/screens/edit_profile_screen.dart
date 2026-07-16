import 'dart:io';

import 'package:flowery/config/helpers/validators.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/modules/profile/presentation/view_models/cubit/edit_profile_view_model.dart';
import 'package:flowery/modules/profile/presentation/view_models/cubit/uplaod_profile_photo_view_model.dart';
import 'package:flowery/modules/profile/presentation/widgets/avatar_picker.dart';
import 'package:flowery/modules/profile/presentation/widgets/gender_selector.dart';
import 'package:flowery/modules/profile/presentation/widgets/labeled_field.dart';
import 'package:flowery/modules/profile/presentation/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flowery/modules/profile/presentation/view_models/events/edit_profile_events.dart';
import 'package:flowery/modules/profile/presentation/view_models/states/edit_profile_state.dart';

import 'package:flowery/modules/profile/presentation/view_models/events/upload_profile_photo_event.dart';
import 'package:flowery/modules/profile/presentation/view_models/states/upload_profile_photo_state.dart';

class EditProfileScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String gender; // "male" | "female"
  final String photo; // network image URL

  const EditProfileScreen({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.gender,
    required this.photo,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}
class EditProfileScreenArgs {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String gender;
  final String photo;

  const EditProfileScreenArgs({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.gender,
    required this.photo,
  });
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.firstName);
    _lastNameController = TextEditingController(text: widget.lastName);
    _emailController = TextEditingController(text: widget.email);
    _phoneController = TextEditingController(text: widget.phone);
    context.read<EditProfileViewModel>().doEvent(
      GenderChanged(widget.gender),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickAndUploadImage(BuildContext context) async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked == null) return;
    if (!context.mounted) return;

    context.read<UplaodProfilePhotoViewModel>().doEvent(
      UploadProfilePhoto(File(picked.path)),
    );
  }

  String? _mapValidationError(ValidationError? error) {
    switch (error) {
      case null:
        return null;
      case ValidationError.required:
        return 'This field is required';
      case ValidationError.invalidName:
        return 'Enter a valid name';
      case ValidationError.invalidEmail:
        return 'Enter a valid email';
      case ValidationError.invalidPhoneNumber:
        return 'Enter a valid phone number';
      case ValidationError.invalidPassword:
      case ValidationError.invalidConfirmPassword:
      case ValidationError.passwordMismatch:
        return null; // not used on this screen
    }
  }

  void _onUpdatePressed(String currentGender) {
    if (!_formKey.currentState!.validate()) return;

    context.read<EditProfileViewModel>().doEvent(
      UpdateProfileInfoEvent(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        gender: currentGender,
      ),
    );
  }

  void _onChangePasswordTap() {
    // Navigator.of(context).pushNamed(AppRoutes.changePassword);
  }



  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title:  Text(localizations.edit_profile),
        centerTitle: false,
        elevation: 0,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<EditProfileViewModel, EditProfileState>(
            listener: (context, state) {
              if (state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage!)),
                );
              } else if (state.data != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.data!.message ?? 'Profile updated'),
                  ),
                );
                Navigator.of(context).pop();
              }
            },
          ),
          BlocListener<UplaodProfilePhotoViewModel, UploadProfilePhotoState>(
            listener: (context, state) {
              if (state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage!)),
                );
              }
            },
          ),
        ],
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AvatarPicker(
                    fallbackPhotoUrl: widget.photo,
                    onTap: () => _pickAndUploadImage(context),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      Expanded(
                        child: LabeledField(
                          label: localizations.first_name,
                          controller: _firstNameController,
                          validator: (v) =>
                              _mapValidationError(Validations.validateName(v)),
                        ),
                      ),
                      const SizedBox(width: 12), 
                      Expanded(
                        child: LabeledField(
                          label: localizations.last_name,
                          controller: _lastNameController,
                          validator: (v) =>
                              _mapValidationError(Validations.validateName(v)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LabeledField(
                    label: localizations.email,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) =>
                        _mapValidationError(Validations.validateEmail(v)),
                  ),
                  const SizedBox(height: 16),
                  LabeledField(
                    label: localizations.phone_number,
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (v) => _mapValidationError(
                      Validations.validatePhoneNumber(v),
                    ),
                  ),
                  const SizedBox(height: 16),
                  PasswordField(onChangeTap: _onChangePasswordTap),
                  const SizedBox(height: 20),
                  BlocBuilder<EditProfileViewModel, EditProfileState>(
                    builder: (context, state) {
                      final currentGender = state.gender ?? widget.gender;
                      return GenderSelector(
                        selected: currentGender,
                        onChanged: (g) => context
                            .read<EditProfileViewModel>()
                            .doEvent(GenderChanged(g)),
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                  BlocBuilder<EditProfileViewModel, EditProfileState>(
                    builder: (context, state) {
                      final currentGender = state.gender ?? widget.gender;
                      return SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: state.isLoading
                              ? null
                              : () => _onUpdatePressed(currentGender),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.grayColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          child: state.isLoading
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.whiteColor,
                                  ),
                                )
                              :  Text(
                                  localizations.update,
                                  style: TextStyle(color:AppColors.whiteColor),
                                ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}






