import 'package:flowery/modules/profile/domain/use_cases/edit_profile_use_case.dart';
import 'package:flowery/modules/profile/presentation/view_models/events/edit_profile_events.dart';
import 'package:flowery/modules/profile/presentation/view_models/states/edit_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class EditProfileViewModel extends Cubit<EditProfileState> {
  final EditProfileUseCase _editProfileUseCase;
  EditProfileViewModel(this._editProfileUseCase) : super(EditProfileState());

  void doEvent(EditProfileEvents event) {
    switch (event) {
      case UpdateProfileInfoEvent():
        _updateProfileInfo(event);
      case GenderChanged():
        _onGenderChanged(event);
    }
  }

  void _onGenderChanged(GenderChanged event) {
    emit(state.copyWith(genderParam: event.gender));
  }

  Future<void> _updateProfileInfo(UpdateProfileInfoEvent event) async {
    
    final response = await _editProfileUseCase.call(
      event.firstName,
      event.lastName,
      event.email,
      event.phoneNumber,
      // event.gender,
    );
    response.when(
      success: (data) =>
          emit(state.copyWith(isLoadingParam: false, dataParam: data)),
      error: (exception) => emit(
        state.copyWith(
          isLoadingParam: false,
          errorMessageParam: exception.toString(),
        ),
      ),
    );
  }
}
