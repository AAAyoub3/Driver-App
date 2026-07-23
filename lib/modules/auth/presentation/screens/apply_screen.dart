import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/modules/auth/data/models/requests/apply_request.dart';
import 'package:flowery/modules/auth/presentation/view_model/cubit/apply_cubit.dart';
import 'package:flowery/modules/auth/presentation/view_model/events/apply_events.dart';
import 'package:flowery/modules/auth/presentation/view_model/state/apply_state.dart';
import 'package:flowery/modules/auth/presentation/widgets/countries_drop_down_menu.dart';
import 'package:flowery/modules/auth/presentation/widgets/personal_info_container.dart';
import 'package:flowery/modules/auth/presentation/widgets/vehicle_container.dart';
import 'package:flowery/modules/auth/presentation/widgets/welcome_widget.dart';
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
  final _firstLegalController = TextEditingController();
  final _lastLegalController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _idImageController = TextEditingController();
  final _vehicleNumberController = TextEditingController();
  final _licenseController = TextEditingController();
  final picker = ImagePicker();

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(localizations.title)),
      body: BlocBuilder<ApplyCubit, ApplyState>(
        builder: (context, state) {
          final isLoaded =
              state.countriesState.maybeWhen(
                success: (_) => true,
                orElse: () => false,
              ) &&
              state.vehiclesState.maybeWhen(
                success: (_) => true,
                orElse: () => false,
              );
          
          if (!isLoaded) {
            return SizedBox(
              height:
                  MediaQuery.of(context).size.height -
                  kToolbarHeight -
                  MediaQuery.of(context).padding.top,
              child: const Center(child: CircularProgressIndicator()),
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome Container
                    WelcomeWidget(),
                
                    // Countries
                    CountriesDropDownMenu(),
                
                    Divider(thickness: 0.5),
                
                    // Personal Information
                    PersonalInfoContainer(
                      firstLegalController: _firstLegalController,
                      lastLegalController: _lastLegalController,
                      emailController: _emailController,
                      phoneNumberController: _phoneNumberController,
                      passwordController: _passwordController,
                      confirmPasswordController: _confirmPasswordController,
                      idNumberController: _idNumberController,
                      idImageController: _idImageController,
                    ),
                
                    Divider(thickness: 0.5),
                
                    // Vehicle Information
                    VehicleContainer(
                      vehicleNumberController: _vehicleNumberController,
                      licenseController: _licenseController,
                    ),
                
                    // Apply Button
                    ElevatedButton(
                      onPressed: () {
                        final state = context.read<ApplyCubit>().state;
                        if (_formKey.currentState!.validate()) {
                          context.read<ApplyCubit>().doEvent(
                            ApplyEvent(
                              application: ApplyRequest(
                                firstName: _firstLegalController.text,
                                lastName: _lastLegalController.text,
                                email: _emailController.text,
                                phone:
                                    '+${state.selectedCountry!.phoneCode}${_phoneNumberController.text}',
                                password: _passwordController.text,
                                repassword: _confirmPasswordController.text,
                                gender: state.selectedGender,
                                country: state.selectedCountry!.name!,
                                vehicleType: state.selectedVehicle!.id!,
                                vehicleNumber: _vehicleNumberController.text,
                                vehicleLicense: state.uploadedLicense!,
                                nid: _idNumberController.text,
                                nidImg: state.uploadedID!,
                              ),
                            ),
                          );
                        }
                      },
                      child: BlocConsumer<ApplyCubit, ApplyState>(
                        listener: (context, state) {
                          state.applyState.whenOrNull(
                            success: (_) {
                              context.pushReplacementNamed(
                                AppRoutes.applySuccess,
                              );
                            },
                            error: (exception) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(exception.toString())),
                              );
                            },
                          );
                        },
                        builder: (context, state) {
                          return state.applyState.maybeWhen(
                            loading: () => SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: const CircularProgressIndicator(
                                color: AppColors.whiteColor,
                              ),
                            ),
                            orElse: () =>
                                Text(localizations.continueButtonText),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
