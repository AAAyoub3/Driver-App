import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/modules/auth/domain/entity/login_entity.dart';

class LoginStates {
  final BaseState<LoginEntity> loginState;

  const LoginStates({
    this.loginState = const BaseState.initial(),
  });

  LoginStates copyWith({
    BaseState<LoginEntity>? loginState,
  }) {
    return LoginStates(
      loginState: loginState ?? this.loginState,
    );
  }
}
