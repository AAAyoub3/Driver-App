import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/config/helpers/regex.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/core/widgets/custom_drop_down_field.dart';
import 'package:flowery/core/widgets/custom_text_form_field.dart';
import 'package:flowery/modules/auth/domain/entities/apply_body_entity.dart';
import 'package:flowery/modules/auth/domain/entities/country_entity.dart';
import 'package:flowery/modules/auth/presentation/screens/apply_successful.dart';
import 'package:flowery/modules/auth/presentation/view_model/apply_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ApplyScreen extends StatefulWidget {
  const ApplyScreen({super.key});

  @override
  State<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  late AppLocalizations localizations;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CountryEntity? _selectedCountry;
  late TextEditingController _firstLegalController;
  late TextEditingController _lastLegalController;
  late TextEditingController _emailController;
  late TextEditingController _vehicleNumberController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _idNumberController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _licenseController;
  late TextEditingController _idImageController;
  final picker = ImagePicker();
  XFile? licenseImage;
  XFile? idImage;
  late List<String> _vehicleTypes;
  String? _selectedVehicleType;
  String? _selectedGender = 'male';
  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    _vehicleTypes = [
    localizations.sedan,
    localizations.suv,
    localizations.truck,
    localizations.hatchback,
    localizations.pickup,
  ];
    super.didChangeDependencies();
  }

  @override

  void initState() {
    super.initState();
    _firstLegalController = TextEditingController();
    _lastLegalController = TextEditingController();
    _emailController = TextEditingController();
    _vehicleNumberController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _idNumberController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _licenseController = TextEditingController();
    _idImageController = TextEditingController();
    context.read<ApplyCubit>().getCountries();
  }

  @override
  void dispose() {
    _firstLegalController.dispose();
    _lastLegalController.dispose();
    _emailController.dispose();
    _vehicleNumberController.dispose();
    _phoneNumberController.dispose();
    _idNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _licenseController.dispose();
    _idImageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text(localizations.title)),
      body: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.welcomeMessage,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: 5.h),
                Text(
                  localizations.description,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 20.h),
                BlocBuilder<ApplyCubit, BaseState>(
                  buildWhen: (previous, current) =>
                      current.data is List<CountryEntity> ||
                      current.state == StateType.error,
                  builder: (context, state) {
                    if (state.state == StateType.error) {
                      return Text(
                        localizations.errorLoadingCountries,
                        style: TextStyle(color: Colors.red, fontSize: 14.sp),
                      );
                    } else if (state.state == StateType.success) {
                      final countries = state.data as List<CountryEntity>;
                      return CustomDropdownField<CountryEntity>(
                        labelText: localizations.country,
                        hintText: localizations.chooseCountry,
                        value: _selectedCountry,
                        items: countries,
                        itemAsString: (country) =>
                            "${country.flag}   ${country.name} (${country.phoneCode})",
                        onChanged: (country) {
                          setState(() {
                            _selectedCountry = country;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return localizations.validationCountryRequired;
                          }
                          return null;
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                SizedBox(height: 15.h),
                CustomTextFormField(
                  controller: _firstLegalController,
                  labelText: localizations.firstLegalName,
                  hintText: localizations.enterFirstLegalName,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return localizations.validationFirstNameRequired;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h),
                CustomTextFormField(
                  controller: _lastLegalController,
                  labelText: localizations.secondLegalName,
                  hintText: localizations.enterSecondLegalName,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return localizations.validationLastNameRequired;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h),
                CustomDropdownField<String>(
                  labelText: localizations.vehicleType,
                  hintText: localizations.chooseVehicleType,
                  value: _selectedVehicleType,
                  items: _vehicleTypes,
                  itemAsString: (value) => value,
                  onChanged: (value) {
                    setState(() {
                      _selectedVehicleType = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return localizations.validationVehicleTypeRequired;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h),
                CustomTextFormField(
                  controller: _vehicleNumberController,
                  labelText: localizations.vehicleNumber,
                  hintText: localizations.enterVehicleNumber,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return localizations.validationVehicleNumberRequired;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h),
                GestureDetector(
                  onTap: () async {
                    final pickedFile = await picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (pickedFile != null) {
                      setState(() {
                        licenseImage = pickedFile;
                        _licenseController.text = pickedFile.name;
                      });
                    }
                  },
                  child: CustomTextFormField(
                    controller: _licenseController,
                    labelText: localizations.vehicleLicense,
                    hintText: localizations.uploadLicensePhoto,
                    enabled: false,
                    unenabledColor: AppColors.blackColor,
                    suffixIcon: Icon(
                      Icons.upload,
                      color: AppColors.blackColor,
                      size: 24.sp,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return localizations.validationLicenseRequired;
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 15.h),
                CustomTextFormField(
                  controller: _emailController,
                  labelText: localizations.email,
                  hintText: localizations.enterEmail,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return localizations.validationEmailRequired;
                    }
                    if (!AppRegExp.isEmailValid(value)) {
                      return localizations.validationEmailInvalid;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h),
                CustomTextFormField(
                  controller: _phoneNumberController,
                  labelText: localizations.phoneNumber,
                  hintText: localizations.enterPhoneNumber,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return localizations.validationPhoneRequired;
                    }
                    if (value.trim().length < 6) {
                      return localizations.validationPhoneInvalid;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h),
                CustomTextFormField(
                  controller: _idNumberController,
                  labelText: localizations.idNumber,
                  hintText: localizations.enterIdNumber,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return localizations.validationIdNumberRequired;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h),
                GestureDetector(
                  onTap: () async {
                    final pickedFile = await picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (pickedFile != null) {
                      setState(() {
                        idImage = pickedFile;
                        _idImageController.text = pickedFile.name;
                      });
                    }
                  },
                  child: CustomTextFormField(
                    controller: _idImageController,
                    labelText: localizations.idImage,
                    hintText: localizations.uploadIdImage,
                    enabled: false,
                    unenabledColor: AppColors.blackColor,
                    suffixIcon: Icon(
                      Icons.upload,
                      color: AppColors.blackColor,
                      size: 24.sp,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return localizations.validationIdImageRequired;
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 15.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        controller: _passwordController,
                        labelText: localizations.password,
                        hintText: localizations.enterPassword,
                        obscureText: true,
                        enabled: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return localizations.validationPasswordRequired;
                          }
                          if (!AppRegExp.isPasswordValid(value)) {
                            return localizations.validationPasswordInvalid;
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: CustomTextFormField(
                        controller: _confirmPasswordController,
                        labelText: localizations.confirmPassword,
                        hintText: localizations.enterConfirmPassword,
                        obscureText: true,
                        enabled: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return localizations
                                .validationConfirmPasswordRequired;
                          }
                          if (value != _passwordController.text) {
                            return localizations.validationConfirmPasswordMatch;
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                RadioGroup<String>(
                  groupValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        localizations.gender,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.blackColor,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'male',
                            activeColor: AppColors.primaryColor,
                          ),
                          Text(
                            localizations.male,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20.w),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'female',
                            activeColor: AppColors.primaryColor,
                          ),
                          Text(
                            localizations.female,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                BlocListener<ApplyCubit, BaseState>(
                  listener: (context, state) {
                    state.when(
                      initial: () {},
                      loading: () {},
                      success: (data) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ApplySuccessful(),
                          ),
                        );
                      },
                      error: (exception) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(exception.toString())));
                      },
                    );
                  },
                  child: BlocBuilder<ApplyCubit, BaseState>(
                    builder: (context, state) {
                      final isLoading = state.state == StateType.loading;
                      return ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<ApplyCubit>().apply(
                                    ApplyBodyEntity(
                                      country: _selectedCountry!.name,
                                      firstName: _firstLegalController.text,
                                      lastName: _lastLegalController.text,
                                      vehicleType: "676b31a45d05310ca82657ac",
                                      vehicleNumber:
                                          _vehicleNumberController.text,
                                      vehicleLicense: licenseImage!,
                                      nid: _idNumberController.text,
                                      nidImg: idImage!,
                                      email: _emailController.text,
                                      phone:
                                          '+${_selectedCountry!.phoneCode}${_phoneNumberController.text}',
                                      password: _passwordController.text,
                                      repassword:
                                          _confirmPasswordController.text,
                                      gender: _selectedGender!,
                                    ),
                                  );
                                }
                              },
                        child: isLoading
                            ? SizedBox(
                                height: 20.h,
                                width: 20.h,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(localizations.continueButtonText),
                      );
                    },
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
