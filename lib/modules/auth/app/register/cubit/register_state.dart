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
  final List<CoinEntity> coins;
  final CoinEntity defaultCoin;
  final bool obscurePassword;
  final bool obscureConfirmPassword;

  RegisterCredentialState({
    TextEditingController? nameController,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    TextEditingController? confirmPasswordController,
    GlobalKey<FormState>? formKey,
    this.defaultCoin = const CoinEntity.defaultBrl(),
    this.coins = const [],
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
  }) : nameController = nameController ?? TextEditingController(),
      emailController = emailController ?? TextEditingController(),
      passwordController = passwordController ?? TextEditingController(),
      confirmPasswordController = confirmPasswordController ?? TextEditingController(),
      formKey = formKey ?? GlobalKey<FormState>();

  RegisterCredentialState copyWith({
    List<CoinEntity>? coins,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    CoinEntity? defaultCoin,
  }) {
    return RegisterCredentialState(
      nameController: nameController,
      emailController: emailController,
      passwordController: passwordController,
      confirmPasswordController: confirmPasswordController,
      coins: coins ?? this.coins,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
      defaultCoin: defaultCoin ?? this.defaultCoin,
    );
  }

  @override
  List<Object?> get props => [nameController, emailController, passwordController, confirmPasswordController, formKey, coins, defaultCoin, obscurePassword, obscureConfirmPassword];
}

class RegisterCategoriesState extends RegisterState {
  final List<CategoryEntity> categories;
  const RegisterCategoriesState({required this.categories});

  @override
  List<Object?> get props => [categories];
}

class RegisterAccountsState extends RegisterState {
  const RegisterAccountsState();

  @override
  List<Object?> get props => [];
}

class RegisterCardState extends RegisterState {
  const RegisterCardState();

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