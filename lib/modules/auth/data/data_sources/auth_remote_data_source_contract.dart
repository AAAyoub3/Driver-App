import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/auth/data/models/apply_response.dart';
import 'package:flowery/modules/auth/domain/entities/apply_body_entity.dart';

abstract interface class AuthRemoteDataSourceContract {
  Future<Result<ApplyResponse>> sendApplication(ApplyBodyEntity body);
}
