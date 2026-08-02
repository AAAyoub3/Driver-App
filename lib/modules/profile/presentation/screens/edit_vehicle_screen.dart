import 'dart:io';
import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/general_cubit/constants.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/modules/profile/data/models/requests/edit_vieckle_request.dart';
import 'package:flowery/modules/profile/presentation/view_models/cubit/edit_vehicle_view_model.dart';
import 'package:flowery/modules/profile/presentation/view_models/events/edit_vehicle_events.dart';
import 'package:flowery/modules/profile/presentation/view_models/states/edit_vehicle_state.dart';
import 'package:flowery/modules/profile/presentation/widgets/border_field.dart';
import 'package:flowery/modules/profile/presentation/widgets/field_label.dart';
import 'package:flowery/modules/profile/presentation/widgets/vehicle_type_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class EditVehicleScreen extends StatelessWidget {
  final String? vehicleType;
  final String? vehicleNumber;

  const EditVehicleScreen({super.key, this.vehicleType, this.vehicleNumber});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EditVehicleViewModel>()
        ..doEvent(SelectVehicleTypeEvent(vehicleType: vehicleType ?? '')),
      child: _EditVehicleView(initialVehicleNumber: vehicleNumber),
    );
  }
}

class _EditVehicleView extends StatefulWidget {
  final String? initialVehicleNumber;

  const _EditVehicleView({this.initialVehicleNumber});

  @override
  State<_EditVehicleView> createState() => _EditVehicleViewState();
}

class _EditVehicleViewState extends State<_EditVehicleView> {
  late final TextEditingController _vehicleNumberController;
  final List<String> _vehicleTypes = ['Bike', 'Car', 'Van', 'Truck'];

  @override
  void initState() {
    super.initState();
    _vehicleNumberController = TextEditingController(
      text: widget.initialVehicleNumber ?? '',
    );
  }

  @override
  void dispose() {
    _vehicleNumberController.dispose();
    super.dispose();
  }

  Future<void> _pickLicenseFile(BuildContext context) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      context.read<EditVehicleViewModel>().doEvent(
        PickLicenseFileEvent(file: File(picked.path)),
      );
    }
  }

  void _onUpdate(BuildContext context, EditVehicleState state) {
    if (state.selectedVehicleType == null ||
        state.selectedVehicleType!.isEmpty ||
        _vehicleNumberController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all vehicle fields')),
      );
      return;
    }

    context.read<EditVehicleViewModel>().doEvent(
      UpdateVehicleInfoEvent(
        request: EditVehicleRequest(
          vehicleType: state.selectedVehicleType!,
          vehicleNumber: _vehicleNumberController.text.trim(),
          vehicleLicensePath: state.licenseFile?.path,
          vehicleLicense: '',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.blackColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          localizations.edit_vehicle,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(
                  Icons.notifications_none,
                  color: AppColors.blackColor,
                ),
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '3',
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: BlocConsumer<EditVehicleViewModel, EditVehicleState>(
        listener: (context, state) {
          if (state.isDone && state.message != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message!)));
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FieldLabel(label: localizations.vehicle_type),
                      SizedBox(height: 6.h),
                      VehicleTypeDropdown(
                        value: state.selectedVehicleType?.isEmpty ?? true
                            ? null
                            : state.selectedVehicleType,
                        items: _vehicleTypes,
                        onChanged: (value) {
                          if (value != null) {
                            context.read<EditVehicleViewModel>().doEvent(
                              SelectVehicleTypeEvent(vehicleType: value),
                            );
                          }
                        },
                      ),
                      SizedBox(height: 20.h),
                      FieldLabel(label: localizations.vehicle_number),
                      SizedBox(height: 6.h),
                      BorderedField(
                        child: TextField(
                          controller: _vehicleNumberController,
                          textCapitalization: TextCapitalization.characters,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      FieldLabel(label: localizations.vehicle_license),
                      SizedBox(height: 6.h),
                      GestureDetector(
                        onTap: () => _pickLicenseFile(context),
                        child: BorderedField(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  state.licenseFile != null
                                      ? state.licenseFile!.path
                                            .split('/')
                                            .last
                                      : AppConstants.photoNumber,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Icon(Icons.file_upload_outlined, size: 20.sp),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.w),
                child: SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton(
                    onPressed: state.isLoading
                        ? null
                        : () => _onUpdate(context, state),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.hintGrayColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    child: state.isLoading
                        ? SizedBox(
                            width: 22.w,
                            height: 22.w,
                            child: const CircularProgressIndicator(
                              color: AppColors.whiteColor,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            localizations.update,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.whiteColor,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

