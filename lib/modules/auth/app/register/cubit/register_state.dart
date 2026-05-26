part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

class RegisterCredentialState extends RegisterState {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;
  final CoinEntity defaultCoin;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final bool isValidPassword;
  final bool isValidConfirmPassword;

  RegisterCredentialState({
    TextEditingController? nameController,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    TextEditingController? confirmPasswordController,
    GlobalKey<FormState>? formKey,
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.defaultCoin = const CoinEntity.defaultBrl(),
    this.isValidPassword = false,
    this.isValidConfirmPassword = false,
  }) : nameController = nameController ?? TextEditingController(),
      emailController = emailController ?? TextEditingController(),
      passwordController = passwordController ?? TextEditingController(),
      confirmPasswordController = confirmPasswordController ?? TextEditingController(),
      formKey = formKey ?? GlobalKey<FormState>();

  RegisterCredentialState copyWith({
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    CoinEntity? defaultCoin,
    bool? isValidPassword,
    bool? isValidConfirmPassword,
  }) {
    return RegisterCredentialState(
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
      defaultCoin: defaultCoin ?? this.defaultCoin,
      isValidPassword: isValidPassword ?? this.isValidPassword,
      isValidConfirmPassword: isValidConfirmPassword ?? this.isValidConfirmPassword,
    );
  }

  @override
  List<Object?> get props => [nameController, emailController, passwordController, formKey, obscurePassword, defaultCoin];
}

class RegisterCategoriesState extends RegisterState {
  const RegisterCategoriesState();

  @override
  List<Object?> get props => [];
}

class RegisterAccountsState extends RegisterState {
  const RegisterAccountsState();

  @override
  List<Object?> get props => [];
}

class RegisterLoadingState extends RegisterState {
  const RegisterLoadingState();
}

class RegisterFailureState extends RegisterState {
  final String error;
  const RegisterFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}