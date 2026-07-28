import 'package:equatable/equatable.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/modules/auth/domain/entities/apply_response_entity.dart';
import 'package:flowery/modules/auth/domain/entities/country_entity.dart';
import 'package:flowery/modules/auth/domain/entities/vehicle_entity.dart';
import 'package:flowery/modules/auth/presentation/screen_strings/apply_screen_strings.dart';
import 'package:image_picker/image_picker.dart';

class ApplyState extends Equatable {
  final CountryEntity? selectedCountry;
  final VehicleEntity? selectedVehicle;
  final String selectedGender;
  final XFile? uploadedLicense;
  final XFile? uploadedID;
  final BaseState<List<CountryEntity>> countriesState;
  final BaseState<List<VehicleEntity>> vehiclesState;
  final BaseState<ApplyResponseEntity> applyState;
  const ApplyState({
    this.selectedCountry,
    this.selectedVehicle,
    this.selectedGender = ApplyScreenStrings.male,
    this.uploadedID,
    this.uploadedLicense,
    this.countriesState = const BaseState.initial(),
    this.vehiclesState = const BaseState.initial(),
    this.applyState = const BaseState.initial(),
  });

  ApplyState copyWith({
    final CountryEntity? selectedCountry,
    final VehicleEntity? selectedVehicle,
    final String? selectedGender,
    final XFile? uploadedLicense,
    final XFile? uploadedID,
    final BaseState<List<CountryEntity>>? countriesState,
    final BaseState<List<VehicleEntity>>? vehiclesState,
    final BaseState<ApplyResponseEntity>? applyState,
  }) {
    return ApplyState(
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedVehicle: selectedVehicle ?? this.selectedVehicle,
      selectedGender: selectedGender ?? this.selectedGender,
      uploadedLicense: uploadedLicense ?? this.uploadedLicense,
      uploadedID: uploadedID ?? this.uploadedID,
      countriesState: countriesState ?? this.countriesState,
      vehiclesState: vehiclesState ?? this.vehiclesState,
      applyState: applyState ?? this.applyState,
    );
  }

  @override
  List<Object?> get props => [
    selectedCountry,
    selectedGender,
    selectedVehicle,
    uploadedLicense,
    uploadedID,
    countriesState,
    vehiclesState,
    applyState,
  ];
}
