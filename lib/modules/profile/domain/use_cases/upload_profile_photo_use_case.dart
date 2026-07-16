import 'dart:io';

import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/profile/domain/entities/upload_profile_photo_entity.dart';
import 'package:flowery/modules/profile/domain/repo/profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class UploadProfilePhotoUseCase {
  final ProfileRepoContract repo;
  UploadProfilePhotoUseCase(this.repo);

  Future<Result<UploadProfilePhotoEntity>> call(File file) =>
      repo.uploadProfilePhoto(file);
}
