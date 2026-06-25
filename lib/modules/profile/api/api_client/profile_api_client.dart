import 'package:dio/dio.dart';
import 'package:flowery/config/api/app_endpoints.dart';
import 'package:flowery/modules/profile/data/models/responses/change_password_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'profile_api_client.g.dart';

@injectable
@RestApi()
abstract class ProfileApiClient {
  @factoryMethod
  factory ProfileApiClient(Dio dio) = _ProfileApiClient;

  @PATCH(AppEndPoints.changePassword)
  Future<ChangePasswordResponse> changePassword({
    @Body() required Map<String, dynamic> request,
  });
}
