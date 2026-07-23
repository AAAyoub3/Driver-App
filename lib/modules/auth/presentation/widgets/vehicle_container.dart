import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/core/widgets/custom_drop_down_field.dart';
import 'package:flowery/core/widgets/custom_text_form_field.dart';
import 'package:flowery/modules/auth/domain/entities/vehicle_entity.dart';
import 'package:flowery/modules/auth/presentation/screen_validators/apply_screen_validators.dart';
import 'package:flowery/modules/auth/presentation/view_model/cubit/apply_cubit.dart';
import 'package:flowery/modules/auth/presentation/view_model/events/apply_events.dart';
import 'package:flowery/modules/auth/presentation/view_model/state/apply_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class VehicleContainer extends StatefulWidget {
  final TextEditingController _vehicleNumberController;
  final TextEditingController _licenseController;
  const VehicleContainer({
    super.key,
    required TextEditingController vehicleNumberController,
    required TextEditingController licenseController,
  }) : _vehicleNumberController = vehicleNumberController,
       _licenseController = licenseController;

  @override
  State<VehicleContainer> createState() => _VehicleContainerState();
}

class _VehicleContainerState extends State<VehicleContainer> {
  final picker = ImagePicker();
  late AppLocalizations localizations;
  XFile? licenseImage;

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15.h),
        // Vehcile Type
        BlocBuilder<ApplyCubit, ApplyState>(
          builder: (context, state) {
            return state.vehiclesState.when(
              success: (List<VehicleEntity> vehicles) {
                return CustomDropdownField<VehicleEntity>(
                  labelText: localizations.vehicleType,
                  hintText: localizations.chooseVehicleType,
                  value: state.selectedVehicle,
                  items: vehicles,
                  itemAsString: (vehicle) => "${vehicle.type}",
                  onChanged: (vehicle) {
                    context.read<ApplyCubit>().doEvent(
                      SelectVehicleEvent(selectedVehicle: vehicle),
                    );
                  },
                  validator: (value) => ApplyScreenValidators.validateVehicle(
                    value,
                    localizations.validationVehicleTypeRequired,
                  ),
                );
              },
              loading: () => CircularProgressIndicator(),
              error: (error) => Text(error.toString()),
              initial: () => SizedBox.shrink(),
            );
          },
        ),
        SizedBox(height: 15.h),

        // Vehcile Number
        CustomTextFormField(
          controller: widget._vehicleNumberController,
          labelText: localizations.vehicleNumber,
          hintText: localizations.enterVehicleNumber,
          validator: (value) => ApplyScreenValidators.validateTextFormField(
            value,
            localizations.validationVehicleNumberRequired,
          ),
        ),
        SizedBox(height: 15.h),

        // Vehcile License
        GestureDetector(
          onTap: () async {
            licenseImage = await picker.pickImage(source: ImageSource.gallery);
            if (licenseImage != null) {
              context.read<ApplyCubit>().doEvent(
                UploadLicenseEvent(uploadedLicense: licenseImage),
              );
            }
          },
          child: CustomTextFormField(
            controller: widget._licenseController,
            labelText: localizations.vehicleLicense,
            hintText: localizations.uploadLicensePhoto,
            enabled: false,
            unenabledColor: AppColors.blackColor,
            suffixIcon: BlocBuilder<ApplyCubit, ApplyState>(
              builder: ((context, state) {
                if (state.uploadedLicense != null) {
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
              licenseImage,
              localizations.validationLicenseRequired,
            ),
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
