import 'package:flowery/modules/profile/domain/entities/edit_profile_photo_entity.dart';

class EditProfileState {
  bool isLoading = false;
  EditProfileEntity? data;
  String? errorMessage;
  String? gender;

  EditProfileState({
    this.isLoading = false,
    this.data,
    this.errorMessage,
    this.gender,
  });
  EditProfileState copyWith({
    bool? isLoadingParam,
    EditProfileEntity? dataParam,
    String? errorMessageParam,
    String? genderParam,
  }) {
    return EditProfileState(
      isLoading: isLoadingParam ?? isLoading,
      data: dataParam ?? data,
      errorMessage: errorMessageParam ?? errorMessage,
      gender: genderParam ?? gender,
    );
  }
}
