import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/auth/domain/entities/apply_body_entity.dart';
import 'package:flowery/modules/auth/domain/entities/apply_response_entity.dart';
import 'package:flowery/modules/auth/domain/repo/auth_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class ApplyUseCase {
  final AuthRepoContract repository;
  ApplyUseCase(this.repository);

  Future<Result<ApplyResponseEntity>> apply(ApplyBodyEntity body) {
    return repository.sendApplication(body);
  }
}
