import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import 'package:ithring_vest/design_system/widgets/toast_widget.dart';
import 'package:ithring_vest/session.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState()) {
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

    final isRememberMe = (state as LoginInitialState).rememberMe;

    emit(LoginLoadingState());

    Session.localStorage.saveRememberLogin(isRememberMe);
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    _login(email, password);

  }

  Future<void> _login( String email, String password ) async {
    try {
      await Future.delayed(Duration(seconds: 2));
      _dispose();
      emit(LoginInitialState());
    } catch (e) {
      emit(LoginFailureState(error: e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(LoginLoadingState());
    try {
      await Future.delayed(Duration(seconds: 2));
      _dispose();
      emit(LoginInitialState());
    } catch (e) {
      emit(LoginFailureState(error: e.toString()));
    }
  }

  void _dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}