
import 'dart:io';

import 'package:flowery/modules/profile/domain/entities/upload_profile_photo_entity.dart';

class UploadProfilePhotoState {
  File? pickedFile;
  UploadProfilePhotoEntity? file;
  String? errorMessage;

  UploadProfilePhotoState({ this.pickedFile,this.file, this.errorMessage});

  UploadProfilePhotoState copyWith({
    File? pickedFileParam,
    UploadProfilePhotoEntity? fileParam,
    String? errorMessageParam,
  }) {
    return UploadProfilePhotoState(
      pickedFile: pickedFileParam ?? pickedFile,
      file: fileParam ?? file,
      errorMessage: errorMessageParam ?? errorMessage,
    );
  }
}
