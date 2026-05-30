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
  final List<CategoryEntity> selectedCategories;
  const RegisterCategoriesState({ required this.categories, this.selectedCategories = const []});

  RegisterCategoriesState copyWith({
    List<CategoryEntity>? selectedCategories,
  }) {
    return RegisterCategoriesState(
      categories: categories,
      selectedCategories: selectedCategories ?? this.selectedCategories,
    );
  }

  List<CategoryEntity> getRevenueCategoriesList() {
    final List<CategoryEntity> list = [];
    for ( final category in categories ) {
      if ( category.isRevenue ) {
        list.add(category);
      }
    }

    categories.removeWhere((category) => category.isRevenue);
    return list;
  }

  List<CategoryEntity> getEssentialCategoriesList() {
    final List<CategoryEntity> list = [];
    for ( final category in categories ) {
      if ( category.isEssentialExpense ) {
        list.add(category);
      }
    }

    categories.removeWhere((category) => category.isEssentialExpense);
    return list;
  }

  List<CategoryEntity> getNonEssentialCategoriesList() {
    final List<CategoryEntity> list = [];
    for ( final category in categories ) {
      if ( !category.isEssentialExpense ) {
        list.add(category);
      }
    }

    categories.removeWhere((category) => !category.isEssentialExpense);
    return list;
  }

  @override
  List<Object?> get props => [categories];
}

class RegisterCategoriesSelectedState extends RegisterState {
  final List<CategoryEntity> categories;
  final List<Map<String, MoneyMaskedTextController>> valueLimitController;
  final List<Map<String, bool>> isDefaultCoin;
  final List<Map<String, CoinEntity>> categoriesCoin;
  const RegisterCategoriesSelectedState({
    required this.categories,
    this.valueLimitController = const [],
    this.isDefaultCoin = const [],
    this.categoriesCoin = const [],
  });

  RegisterCategoriesSelectedState copyWith({
    List<CategoryEntity>? categories,
    List<Map<String, MoneyMaskedTextController>>? valueLimitController,
    List<Map<String, bool>>? isDefaultCoin,
    List<Map<String, CoinEntity>>? categoriesCoin,
  }) {
    return RegisterCategoriesSelectedState(
      categories: categories ?? this.categories,
      valueLimitController: valueLimitController ?? this.valueLimitController,
      isDefaultCoin: isDefaultCoin ?? this.isDefaultCoin,
      categoriesCoin: categoriesCoin ?? this.categoriesCoin,
    );
  }

  List<CategoryEntity> getRevenueCategoriesList() {
    final List<CategoryEntity> list = [];
    for ( final category in categories ) {
      if ( category.isRevenue ) {
        list.add(category);
      }
    }

    categories.removeWhere((category) => category.isRevenue);
    return list;
  }

  List<CategoryEntity> getEssentialCategoriesList() {
    final List<CategoryEntity> list = [];
    for ( final category in categories ) {
      if ( category.isEssentialExpense ) {
        list.add(category);
      }
    }

    categories.removeWhere((category) => category.isEssentialExpense);
    return list;
  }

  List<CategoryEntity> getNonEssentialCategoriesList() {
    final List<CategoryEntity> list = [];
    for ( final category in categories ) {
      if ( !category.isEssentialExpense ) {
        list.add(category);
      }
    }

    categories.removeWhere((category) => !category.isEssentialExpense);
    return list;
  }

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