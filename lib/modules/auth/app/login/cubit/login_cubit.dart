import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import 'package:ithring_vest/core/domain/source/local/injection/injection.dart';
import 'package:ithring_vest/core/domain/source/local/mobx/user/user_mobx.dart';
import 'package:ithring_vest/core/domain/usecases/auth_use_case.dart';
import 'package:ithring_vest/design_system/widgets/toast_widget.dart';
import 'package:ithring_vest/modules/auth/routes/auth_path.dart';
import 'package:ithring_vest/modules/dashboard/routes/dash_path.dart';
import 'package:ithring_vest/session.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final AuthUseCase _authUseCase;
  LoginCubit(
    this._authUseCase,
  ) : super(LoginInitialState()) {
    fillFields();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> fillFields() async {
    final isRemember = await Session.localStorage.getRememberLogin();
    final email = await Session.localStorage.getLoginEmail();
    final password = await Session.localStorage.getLoginPassword();
    emailController = TextEditingController(text: email);
    passwordController = TextEditingController(text: password);
    toggleRemember(isRemember);
  }

  void togglePwdVisibility() {
    final currentState = state;
    if ( currentState is LoginInitialState ) {
      return emit(
        currentState.copyWith(
          obscurePassword: !currentState.obscurePassword,
        ),
      );
    }
  }

  void toggleRemember( bool value ) {
    final currentState = state;
    if ( currentState is LoginInitialState ) {
      return emit(
        currentState.copyWith(
          rememberMe: value,
        ),
      );
    }
  }

  void validateFields() {
    if ( !formKey.currentState!.validate() ) {
      return showError("toast.error.invalid_fields_red_validations");
    }

    _login();
  }

  Future<void> _login() async {
    final currentState = state as LoginInitialState;
    emit(LoginLoadingState());

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final response = await _authUseCase.loginWithEmail(email, password, currentState.rememberMe);

    response.fold(
      ( failure ) {
        return emit(
          currentState.copyWith(
            error: failure.message,
          ),
        );
      },
      ( user ) {
        final userMobx = getIt<UserMobx>();
        userMobx.setUser(user);

        if ( user.isRegisterFinished ) {
          return Session.navigation.go(DashPath().dashboard);
        }

        _dispose();
        return Session.navigation.go(AuthPath.registerPath.register);
      },
    );
  }

  Future<void> signInWithGoogle() async {
    emit(LoginLoadingState());
    await Future.delayed(Duration(seconds: 2));
    _dispose();
    emit(LoginInitialState());
  }

  void _dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}