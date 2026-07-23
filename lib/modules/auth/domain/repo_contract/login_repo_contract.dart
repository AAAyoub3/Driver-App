
import '../../../../config/base_response/base_response.dart';
import '../../data/models/request/login_request_model.dart';
import '../entity/login_entity.dart';

abstract class LoginRepoContract {
  Future<Result<LoginEntity>> login(LoginRequestModel request);
}