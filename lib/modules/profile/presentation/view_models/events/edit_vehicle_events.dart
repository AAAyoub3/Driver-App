import 'dart:io';
import 'package:flowery/modules/profile/data/models/requests/edit_vieckle_request.dart';

sealed class EditVehicleEvents {}

class UpdateVehicleInfoEvent extends EditVehicleEvents {
  final EditVehicleRequest request;

  UpdateVehicleInfoEvent({required this.request});
}

class SelectVehicleTypeEvent extends EditVehicleEvents {
  final String vehicleType;

  SelectVehicleTypeEvent({required this.vehicleType});
}

class PickLicenseFileEvent extends EditVehicleEvents {
  final File file;

  PickLicenseFileEvent({required this.file});
}