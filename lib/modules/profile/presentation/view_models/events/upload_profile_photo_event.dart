import 'dart:io';

sealed class UploadProfilePhotoEvent {}

class UploadProfilePhoto extends UploadProfilePhotoEvent {
  File file;
  UploadProfilePhoto(this.file);
}
