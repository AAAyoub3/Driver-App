import 'dart:io';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/profile/data/models/responses/edit_vieckle_response.dart';
import 'package:flowery/modules/profile/domain/use_cases/edit_vieckle_info_use_case.dart';
import 'package:flowery/modules/profile/presentation/view_models/events/edit_vehicle_events.dart';
import 'package:flowery/modules/profile/presentation/view_models/states/edit_vehicle_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditVehicleViewModel extends Cubit<EditVehicleState> {
  final EditVehicleUseCase _editVehicleUseCase;

  EditVehicleViewModel(this._editVehicleUseCase) : super(EditVehicleState());

  void doEvent(EditVehicleEvents event) {
    switch (event) {
      case UpdateVehicleInfoEvent():
        _updateVehicleInfo(event);
      case SelectVehicleTypeEvent():
        emit(state.copyWith(selectedVehicleType: event.vehicleType));
      case PickLicenseFileEvent():
        emit(state.copyWith(licenseFile: event.file));
    }
  }

  Future<void> _updateVehicleInfo(UpdateVehicleInfoEvent event) async {
    emit(state.copyWith(isLoading: true, isDone: false));
    final response = await _editVehicleUseCase.call(request: event.request);
    switch (response) {
      case Success<EditVieckleResponse>():
        emit(
          state.copyWith(
            isLoading: false,
            isDone: true,
            message: response.data?.message,
          ),
        );
      case Error<EditVieckleResponse>():
        emit(
          state.copyWith(
            isLoading: false,
            isDone: true,
            message: response.exception.toString(),
          ),
        );
    }
  }
}