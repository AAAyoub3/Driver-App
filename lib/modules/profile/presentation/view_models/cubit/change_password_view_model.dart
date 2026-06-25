import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/profile/domain/entities/change_password_entity.dart';
import 'package:flowery/modules/profile/domain/use_cases/change_password_use_case.dart';
import 'package:flowery/modules/profile/presentation/view_models/events/change_password_events.dart';
import 'package:flowery/modules/profile/presentation/view_models/states/change_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordViewModel extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;
  ChangePasswordViewModel(this._changePasswordUseCase)
    : super(ChangePasswordState());

  void doEvent(ChangePasswordEvents event) {
    switch (event) {
      case UpdatePasswordEvent():
        _updatePassword(event);
    }
  }

  Future<void> _updatePassword(UpdatePasswordEvent event) async {
    emit(state.copyWith(isLoading: true, isDone: false));
    final response = await _changePasswordUseCase.call(
      event.password,
      event.newPassword,
    );
    switch (response) {
      case Success<ChangePasswordEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            isDone: true,
            message: response.data?.message,
          ),
        );
      case Error<ChangePasswordEntity>():
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
