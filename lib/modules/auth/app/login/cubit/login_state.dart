part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitialState extends LoginState {
  final bool obscurePassword;
  final bool rememberMe;
  final String? error;
  const LoginInitialState({
    this.obscurePassword = true,
    this.rememberMe = true,
    this.error,
  });

  LoginInitialState copyWith({
    bool? obscurePassword,
    bool? rememberMe,
    String? error,
  }) {
    return LoginInitialState(
      obscurePassword: obscurePassword ?? this.obscurePassword,
      rememberMe: rememberMe ?? this.rememberMe,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [obscurePassword, rememberMe, error];
}

class LoginLoadingState extends LoginState {
  const LoginLoadingState();
}