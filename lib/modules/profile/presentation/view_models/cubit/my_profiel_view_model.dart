import 'package:flowery/modules/profile/domain/use_cases/get_my_profile_data_use_case.dart';
import 'package:flowery/modules/profile/presentation/view_models/events/my_profile_event.dart';
import 'package:flowery/modules/profile/presentation/view_models/states/get_profile_data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class MyProfielViewModel extends Cubit<GetProfileDataState> {
  final GetMyProfileDataUseCase _getMyProfileDataUseCase;
  MyProfielViewModel(this._getMyProfileDataUseCase)
    : super(GetProfileDataState());

  void doEvent(MyProfileEvent event) {
    switch (event) {
      case GetMyprofileData():
        _getProfileData();
    }
  }

  Future<void> _getProfileData() async {
    final response = await _getMyProfileDataUseCase.call();
    response.when(
      success: (data) =>
          emit(state.copyWith(isLoadingDataParam: false, dataParam: data)),
      error: (exception) => emit(
        state.copyWith(
          isLoadingDataParam: false,
          errorMessageParam: exception.toString(),
        ),
      ),
    );
  }
}
