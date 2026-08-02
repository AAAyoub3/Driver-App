import 'package:flowery/modules/profile/domain/entities/my_profile_entity.dart';

class GetProfileDataState {
  bool isLoadingData = true;
  MyProfileEntity? data;
  String? errorMessage;
  GetProfileDataState({
    this.isLoadingData = true,
    this.data,
    this.errorMessage,
  });
  GetProfileDataState copyWith({
    bool? isLoadingDataParam,
    MyProfileEntity? dataParam,
    String? errorMessageParam,
  }) {
    return GetProfileDataState(
      isLoadingData: isLoadingDataParam ?? isLoadingData,
      data: dataParam ?? data,
      errorMessage: errorMessageParam ?? errorMessage,
    );
  }
}
