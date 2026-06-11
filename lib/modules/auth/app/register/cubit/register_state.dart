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

  void dispose() {
    nameController.clear();
    nameController.dispose();
    emailController.clear();
    emailController.dispose();
    passwordController.clear();
    passwordController.dispose();
    confirmPasswordController.clear();
    confirmPasswordController.dispose();
  }

  @override
  List<Object?> get props => [nameController, emailController, passwordController, confirmPasswordController, formKey, coins, defaultCoin, obscurePassword, obscureConfirmPassword];
}

class RegisterCategoriesState extends RegisterState {
  final List<CategoryEntity> categories;
  const RegisterCategoriesState({ required this.categories });

  RegisterCategoriesState copyWith({
    List<CategoryEntity>? categories,
  }) {
    return RegisterCategoriesState(
      categories: categories ?? this.categories,
    );
  }

  List<CategoryEntity> getRevenueCategoriesList() {
    final List<CategoryEntity> list = [];
    for ( final category in categories ) {
      if ( category.isRevenue ) {
        list.add(category);
      }
    }

    return list;
  }

  List<CategoryEntity> getEssentialCategoriesList() {
    final List<CategoryEntity> list = [];
    for ( final category in categories ) {
      if ( category.isEssentialExpense ) {
        list.add(category);
      }
    }

    return list;
  }

  List<CategoryEntity> getNonEssentialCategoriesList() {
    final List<CategoryEntity> list = [];
    for ( final category in categories ) {
      if ( !category.isEssentialExpense && !category.isRevenue ) {
        list.add(category);
      }
    }

    return list;
  }

  void dispose() {
    categories.clear();
  }

  @override
  List<Object?> get props => [categories];
}

class RegisterCategoriesSelectedState extends RegisterState {
  final Map<String, MoneyMaskedTextController> controllers;
  final List<CategoryEntity> categories;
  final List<CoinEntity> coins;
  const RegisterCategoriesSelectedState({
    GlobalKey<FormState>? formKey,
    this.controllers = const {},
    this.categories = const [],
    this.coins = const [],
  });

  CoinEntity getDefaultCoin() {
    return coins.firstWhere((coin) => coin.symbol == Session.user.coinSymbol);
  }

  MoneyMaskedTextController? getController(String categoryId) {
    return controllers[categoryId];
  }

  RegisterCategoriesSelectedState copyWith({
    Map<String, MoneyMaskedTextController>? controllers,
    List<CategoryEntity>? categories,
    List<CoinEntity>? coins,
  }) {
    return RegisterCategoriesSelectedState(
      controllers: controllers ?? this.controllers,
      categories: categories ?? this.categories,
      coins: coins ?? this.coins,
    );
  }

  void dispose() {
    for ( final category in categories ) {
      controllers[category.id]?.clear();
      controllers[category.id]?.dispose();
    }

    controllers.clear();
  }

  @override
  List<Object?> get props => [controllers, categories, coins];
}

class RegisterAccountsState extends RegisterState {
  final List<TypeAccountEntity> typeAccounts;
  final List<CoinEntity> coins;
  const RegisterAccountsState({
    this.typeAccounts = const [],
    this.coins = const [],
  });

  CoinEntity getDefaultCoin() {
    return coins.firstWhere((coin) => coin.symbol == Session.user.coinSymbol);
  }

  @override
  List<Object?> get props => [typeAccounts, coins];
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