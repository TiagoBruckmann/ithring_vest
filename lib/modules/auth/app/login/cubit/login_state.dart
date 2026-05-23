part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitialState extends LoginState {
  final bool obscurePassword;
  final bool rememberMe;
  const LoginInitialState({
    this.obscurePassword = true,
    this.rememberMe = true,
  });

  LoginInitialState copyWith({
    bool? obscurePassword,
    bool? rememberMe,
  }) {
    return LoginInitialState(
      obscurePassword: obscurePassword ?? this.obscurePassword,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }

  @override
  List<Object?> get props => [obscurePassword, rememberMe];
}

class LoginLoadingState extends LoginState {
  const LoginLoadingState();
}

class LoginFailureState extends LoginState {
  final String error;
  const LoginFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}