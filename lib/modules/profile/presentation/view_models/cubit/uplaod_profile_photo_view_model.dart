import 'package:flowery/modules/profile/domain/use_cases/upload_profile_photo_use_case.dart';
import 'package:flowery/modules/profile/presentation/view_models/events/upload_profile_photo_event.dart';
import 'package:flowery/modules/profile/presentation/view_models/states/upload_profile_photo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class UplaodProfilePhotoViewModel extends Cubit<UploadProfilePhotoState> {
  final UploadProfilePhotoUseCase _uploadProfilePhotoUseCase;

  UplaodProfilePhotoViewModel(this._uploadProfilePhotoUseCase)
    : super(UploadProfilePhotoState());

  void doEvent(UploadProfilePhotoEvent event) {
    switch (event) {
      case UploadProfilePhoto():
        _uploadProfilePhoto(event);
    }
  }

  Future<void> _uploadProfilePhoto(UploadProfilePhoto event) async {
    emit(state.copyWith(pickedFileParam: event.file));
    final response = await _uploadProfilePhotoUseCase.call(event.file);
    response.when(
      success: (data) => emit(state.copyWith(fileParam: data)),
      error: (exception) =>
          emit(state.copyWith(errorMessageParam: exception.toString())),
    );
  }
}
