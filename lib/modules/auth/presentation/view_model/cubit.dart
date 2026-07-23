import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/modules/auth/data/models/request/login_request_model.dart';
import 'package:flowery/modules/auth/domain/entity/login_entity.dart';
import 'package:flowery/modules/auth/domain/use_case/login_use_case.dart';
import 'package:flowery/modules/auth/presentation/view_model/event.dart';
import 'package:flowery/modules/auth/presentation/view_model/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(this._loginUseCase) : super(const LoginStates());

  final LoginUseCase _loginUseCase;

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void doEvent(LoginEvents event) {
    switch (event) {
      case LoginEvent():
        _login(event);
        break;

      case NavigateToRegisterEvent():
        _navigateToRegister();
        break;
    }
  }

  Future<void> _login(LoginEvent event) async {
    emit(
      state.copyWith(
        loginState: const BaseState.loading(),
      ),
    );

    final response = await _loginUseCase(
      LoginRequestModel(
        email: event.email,
        password: event.password,
      ),
    );

    switch (response) {
      case Success<LoginEntity>():
        emit(
          state.copyWith(
            loginState: BaseState.success(response.data!),
          ),
        );
        break;

      case Error<LoginEntity>():
        emit(
          state.copyWith(
            loginState: BaseState.error(response.exception!),
          ),
        );
        break;
    }
  }

  void _navigateToRegister() {}

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
