import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/core/widgets/custom_text_form_field.dart';
import 'package:flowery/modules/auth/presentation/screen_validators/apply_screen_validators.dart';
import 'package:flowery/modules/auth/presentation/view_model/cubit/apply_cubit.dart';
import 'package:flowery/modules/auth/presentation/view_model/events/apply_events.dart';
import 'package:flowery/modules/auth/presentation/view_model/state/apply_state.dart';
import 'package:flowery/modules/auth/presentation/widgets/gender_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class PersonalInfoContainer extends StatefulWidget {
  final TextEditingController _firstLegalController;
  final TextEditingController _lastLegalController;
  final TextEditingController _emailController;
  final TextEditingController _phoneNumberController;
  final TextEditingController _passwordController;
  final TextEditingController _confirmPasswordController;
  final TextEditingController _idNumberController;
  final TextEditingController _idImageController;


  PersonalInfoContainer({
    super.key,
    required TextEditingController firstLegalController,
    required TextEditingController lastLegalController,
    required TextEditingController emailController,
    required TextEditingController phoneNumberController,
    required TextEditingController passwordController,
    required TextEditingController confirmPasswordController,
    required TextEditingController idNumberController,
    required TextEditingController idImageController,
  }) : _firstLegalController = firstLegalController,
       _lastLegalController = lastLegalController,
       _emailController = emailController,
       _phoneNumberController = phoneNumberController,
       _passwordController = passwordController,
       _confirmPasswordController = confirmPasswordController,
       _idNumberController = idNumberController,
       _idImageController = idImageController;

  @override
  State<PersonalInfoContainer> createState() => _PersonalInfoContainerState();
}

class _PersonalInfoContainerState extends State<PersonalInfoContainer> {
  final picker = ImagePicker();
  XFile? pickedIdImage;
  late AppLocalizations localizations;

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15.h),
        // First Legal Name
        CustomTextFormField(
          controller: widget._firstLegalController,
          labelText: localizations.firstLegalName,
          hintText: localizations.enterFirstLegalName,
          validator: (value) => ApplyScreenValidators.validateTextFormField(
            value,
            localizations.validationFirstNameRequired,
          ),
        ),
        SizedBox(height: 15.h),

        // Last Legal Name
        CustomTextFormField(
          controller: widget._lastLegalController,
          labelText: localizations.secondLegalName,
          hintText: localizations.enterSecondLegalName,
          validator: (value) => ApplyScreenValidators.validateTextFormField(
            value,
            localizations.validationLastNameRequired,
          ),
        ),
        SizedBox(height: 15.h),

        // Phone
        CustomTextFormField(
          controller: widget._phoneNumberController,
          labelText: localizations.phoneNumber,
          hintText: localizations.enterPhoneNumber,
          keyboardType: TextInputType.phone,
          validator: (phone) => ApplyScreenValidators.validatePhoneNumber(
            phone,
            localizations.validationPhoneRequired,
            localizations.validationPhoneInvalid,
          ),
        ),
        SizedBox(height: 15.h),

        // Email
        CustomTextFormField(
          controller: widget._emailController,
          labelText: localizations.email,
          hintText: localizations.enterEmail,
          keyboardType: TextInputType.emailAddress,
          validator: (email) => ApplyScreenValidators.validateEmail(
            email,
            localizations.validationEmailRequired,
            localizations.validationEmailInvalid,
          ),
        ),
        SizedBox(height: 15.h),

        // Password
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomTextFormField(
                controller: widget._passwordController,
                labelText: localizations.password,
                hintText: localizations.enterPassword,
                obscureText: true,
                enabled: true,
                validator: (password) => ApplyScreenValidators.validatePassword(
                  password,
                  localizations.validationPasswordInvalid,
                  localizations.validationPasswordRequired,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: CustomTextFormField(
                controller: widget._confirmPasswordController,
                labelText: localizations.confirmPassword,
                hintText: localizations.enterConfirmPassword,
                obscureText: true,
                enabled: true,
                validator: (confirmPassword) =>
                    ApplyScreenValidators.validateConfirmPassword(
                      confirmPassword,
                      widget._passwordController.text,
                      localizations.validationConfirmPasswordRequired,
                      localizations.validationConfirmPasswordMatch,
                    ),
              ),
            ),
          ],
        ),

        // Gender
        GenderContainer(),
        SizedBox(height: 15.h),

        Divider(thickness: 0.5),
        SizedBox(height: 15.h),

        // ID Number
        CustomTextFormField(
          controller: widget._idNumberController,
          labelText: localizations.idNumber,
          hintText: localizations.enterIdNumber,
          validator: (id) => ApplyScreenValidators.validateTextFormField(
            id,
            localizations.validationIdNumberRequired,
          ),
        ),
        SizedBox(height: 15.h),

        // ID Image
        GestureDetector(
          onTap: () async {
            pickedIdImage = await picker.pickImage(source: ImageSource.gallery);
            if (pickedIdImage != null) {
              context.read<ApplyCubit>().doEvent(
                UploadIDEvent(uploadedID: pickedIdImage),
              );
            }
          },
          child: CustomTextFormField(
            controller: widget._idImageController,
            labelText: localizations.idImage,
            hintText: localizations.uploadIdImage,
            enabled: false,
            unenabledColor: AppColors.blackColor,
            suffixIcon: BlocBuilder<ApplyCubit, ApplyState>(
              builder: ((context, state) {
                if (state.uploadedID != null) {
                  return Icon(
                    Icons.file_upload_outlined,
                    color: AppColors.greenColor,
                  );
                }
                return Icon(
                  Icons.file_upload_outlined,
                  color: AppColors.blackColor,
                );
              }),
            ),
            validator: (_) => ApplyScreenValidators.validateFile(
              pickedIdImage,
              localizations.validationIdImageRequired,
            ),
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
