import 'package:flowery/modules/auth/data/models/requests/apply_request.dart';
import 'package:flowery/modules/auth/domain/entities/country_entity.dart';
import 'package:flowery/modules/auth/domain/entities/vehicle_entity.dart';
import 'package:image_picker/image_picker.dart';

sealed class ApplyEvents {}

class GetCountriesEvent extends ApplyEvents {}

class GetVehiclesEvent extends ApplyEvents {}

class ApplyEvent extends ApplyEvents {
  final ApplyRequest application;

  ApplyEvent({required this.application});
}

class SelectCountryEvent extends ApplyEvents {
  final CountryEntity? selectedCountry;

  SelectCountryEvent({required this.selectedCountry});
}

class SelectGenderEvent extends ApplyEvents {
  final String? selectedGender;

  SelectGenderEvent({required this.selectedGender});
}

class SelectVehicleEvent extends ApplyEvents {
  final VehicleEntity? selectedVehicle;

  SelectVehicleEvent({required this.selectedVehicle});
}

class UploadLicenseEvent extends ApplyEvents {
  final XFile? uploadedLicense;

  UploadLicenseEvent({required this.uploadedLicense});
}

class UploadIDEvent extends ApplyEvents {
  final XFile? uploadedID;

  UploadIDEvent({required this.uploadedID});
}
