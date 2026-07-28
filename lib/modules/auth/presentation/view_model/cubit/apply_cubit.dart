import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/modules/auth/domain/entities/apply_response_entity.dart';
import 'package:flowery/modules/auth/domain/entities/country_entity.dart';
import 'package:flowery/modules/auth/domain/entities/vehicle_entity.dart';
import 'package:flowery/modules/auth/domain/use_cases/apply_use_case.dart';
import 'package:flowery/modules/auth/domain/use_cases/get_countries_use_case.dart';
import 'package:flowery/modules/auth/domain/use_cases/get_vehicles_use_case.dart';
import 'package:flowery/modules/auth/presentation/view_model/events/apply_events.dart';
import 'package:flowery/modules/auth/presentation/view_model/state/apply_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ApplyCubit extends Cubit<ApplyState> {
  final GetCountriesUseCase _getCountriesUseCase;
  final GetVehiclesUseCase _getVehiclesUseCase;
  final ApplyUseCase _applyUseCase;
  ApplyCubit(
    this._getCountriesUseCase,
    this._applyUseCase,
    this._getVehiclesUseCase,
  ) : super(ApplyState());

  void doEvent(ApplyEvents event) {
    switch (event) {
      case GetCountriesEvent():
        _getCountries();
      case GetVehiclesEvent():
         _getVehicles();
      case SelectCountryEvent():
        _selectCountry(event);
      case SelectVehicleEvent():
        _selectVehicle(event);
      case SelectGenderEvent():
        _selectGender(event);
      case UploadLicenseEvent():
        _uploadLicense(event);
      case UploadIDEvent():
        _uploadId(event);
      case ApplyEvent():
        _apply(event);
    }
  }

  void _selectGender(SelectGenderEvent event) {
    emit(state.copyWith(selectedGender: event.selectedGender));
  }

  void _uploadId(UploadIDEvent event) {
    emit(state.copyWith(uploadedID: event.uploadedID));
  }

  void _uploadLicense(UploadLicenseEvent event) {
    emit(state.copyWith(uploadedLicense: event.uploadedLicense));
  }

  void _selectCountry(SelectCountryEvent event) {
    emit(state.copyWith(selectedCountry: event.selectedCountry));
  }

  void _selectVehicle(SelectVehicleEvent event) {
    emit(state.copyWith(selectedVehicle: event.selectedVehicle));
  }

  Future<void> _getCountries() async {
    emit(state.copyWith(countriesState: const BaseState.loading()));
    final response = await _getCountriesUseCase.call();
    switch (response) {
      case Success<List<CountryEntity>>():
        emit(state.copyWith(countriesState: BaseState.success(response.data)));
      case Error<List<CountryEntity>>():
        emit(
          state.copyWith(countriesState: BaseState.error(response.exception)),
        );
    }
  }

    Future<void> _getVehicles() async {
    emit(state.copyWith(vehiclesState: const BaseState.loading()));
    final response = await _getVehiclesUseCase.call();
    switch (response) {
      case Success<List<VehicleEntity>>():
        emit(state.copyWith(vehiclesState: BaseState.success(response.data)));
      case Error<List<VehicleEntity>>():
        emit(
          state.copyWith(vehiclesState: BaseState.error(response.exception)),
        );
    }
  }

  Future<void> _apply(ApplyEvent event) async {
    emit(state.copyWith(applyState: const BaseState.loading()));
    final response = await _applyUseCase.call(event.application);
    switch(response){
      case Success<ApplyResponseEntity>():
        emit(state.copyWith(applyState: BaseState.success(response.data)));
      case Error<ApplyResponseEntity>():
                emit(
          state.copyWith(applyState: BaseState.error(response.exception)),
        );
    }
  }
}
