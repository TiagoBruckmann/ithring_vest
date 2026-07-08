import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import 'package:ithring_vest/core/domain/entities/account_entity.dart';
import 'package:ithring_vest/core/domain/entities/card_entity.dart';
import 'package:ithring_vest/core/domain/entities/category_entity.dart';
import 'package:ithring_vest/core/domain/entities/coin_entity.dart';
import 'package:ithring_vest/core/domain/entities/type_account_entity.dart';
import 'package:ithring_vest/core/domain/entities/user_entity.dart';
import 'package:ithring_vest/core/domain/enums/step_missing_enum.dart';
import 'package:ithring_vest/core/domain/usecases/account_use_case.dart';
import 'package:ithring_vest/core/domain/usecases/auth_use_case.dart';
import 'package:ithring_vest/core/domain/usecases/card_use_case.dart';
import 'package:ithring_vest/core/domain/usecases/category_use_case.dart';
import 'package:ithring_vest/core/domain/usecases/coin_use_case.dart';
import 'package:ithring_vest/core/domain/usecases/type_account_use_case.dart';
import 'package:ithring_vest/core/domain/usecases/user_use_case.dart';
import 'package:ithring_vest/design_system/widgets/toast_widget.dart';
import 'package:ithring_vest/modules/dashboard/routes/dash_path.dart';
import 'package:ithring_vest/session.dart';

part 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final TypeAccountUseCase _typeAccountUseCase;
  final CategoryUseCase _categoryUseCase;
  final AccountUseCase _accountUseCase;
  final CardUseCase _cardUseCase;
  final UserUseCase _userUseCase;
  final AuthUseCase _authUseCase;
  final CoinUseCase _coinUseCase;
  RegisterCubit(
    this._typeAccountUseCase,
    this._categoryUseCase,
    this._accountUseCase,
    this._cardUseCase,
    this._userUseCase,
    this._authUseCase,
    this._coinUseCase,
  ) : super(RegisterCredentialState()) {
    _getInitialData();
  }

  final List<CoinEntity> coins = [];

  Future<void> _getInitialData() async {
    emit(RegisterLoadingState());

    if ( Session.user.stepMissing == StepMissingEnum.categories.name ) {
      return await _getDefaultCategories();
    }

    if ( Session.user.stepMissing == StepMissingEnum.categoriesSelected.name ) {
      await Future.wait([
        _getCoins(isCredentialState: false),
        _getUserCategories(),
      ]);

      return;
    }

    if ( Session.user.stepMissing == StepMissingEnum.accounts.name ) {
      await Future.wait([
        _getCoins(isCredentialState: false),
        _getDefaultTypeAccounts(),
      ]);

      return;
    }

    if ( Session.user.stepMissing == StepMissingEnum.creditCard.name ) {
      return await _getAccount();
    }

    await _getCoins();
  }

  Future<void> _getCoins({ bool isCredentialState = true }) async {
    final result = await _coinUseCase.getCoins();
    result.fold(
      (failure) {
        coins.add(CoinEntity.defaultBrl());

        if ( !isCredentialState ) return;

        return emit(
          RegisterCredentialState(
            coins: coins,
            defaultCoin: coins.first,
          ),
        );
      },
      (coins) {
        this.coins.addAll(coins);

        if ( !isCredentialState ) return;

        return emit(
          RegisterCredentialState(
            coins: coins,
            defaultCoin: CoinEntity.defaultBrl(),
          ),
        );

      },
    );
  }

  Future<void> _getDefaultCategories() async {
    final result = await _categoryUseCase.getDefaultCategories();
    result.fold(
      (failure) {
        showError("toast.error.categories_not_loaded");
        return emit(RegisterCredentialState());
      },
      (categories) => emit(RegisterCategoriesState(categories: categories)),
    );
  }

  Future<void> _getUserCategories() async {
    final result = await _categoryUseCase.getUserCategories();
    result.fold(
      (failure) {
        showError("toast.error.categories_not_loaded");
        return emit(RegisterCategoriesState(categories: []));
      },
      (categories) {
        return emit(
          RegisterCategoriesSelectedState(
            controllers: _manageCategoriesController(categories),
            categories: categories,
            coins: coins,
          ),
        );
      }
    );
  }

  Future<void> _getDefaultTypeAccounts() async {
    final result = await _typeAccountUseCase.getDefaultTypeAccount();
    result.fold(
      ( failure ) {
        showError("toast.error.default_type_accounts_not_loaded");
        return emit(
          RegisterAccountsState(coins: coins),
        );
      },
      ( typeAccounts ) {
        return emit(
          RegisterAccountsState(
            typeAccounts: typeAccounts,
            coins: coins,
          ),
        );
      }
    );
  }

  Future<void> _getAccount() async {
    final result = await _accountUseCase.getUserAccounts();
    result.fold(
      ( failure ) {
        showError("toast.error.accounts_not_loaded");
        return emit(
          RegisterCredentialState(),
        );
      },
      ( accounts ) {
        return emit(
          RegisterCardState(account: accounts.first),
        );
      }
    );
  }

  void selectCoin( CoinEntity coin, { CategoryEntity? category }) {
    final currentState = state;
    if ( currentState is RegisterCredentialState ) {
      return emit(
        currentState.copyWith(
          defaultCoin: coin,
        ),
      );
    }

    if ( currentState is RegisterCategoriesSelectedState && category != null ) {

      category = category.copyWith(coin: coin);
      final categories = List<CategoryEntity>.from(currentState.categories);

      final index = categories.indexWhere((item) => item.id == category!.id);
      if ( !index.isNegative ) {
        categories[index] = category;
      }

      return emit(
        currentState.copyWith(
          controllers: _manageCategoriesController(categories),
          categories: categories,
        ),
      );
    }

    if ( currentState is RegisterAccountsState ) {
      return emit(
        currentState.copyWith(
          defaultCoin: coin,
        ),
      );
    }
  }

  /// ***********************
  /// CRIAÇÃO DO USUÁRIO
  /// ***********************

  void togglePwdVisibility() {
    final currentState = state;
    if ( currentState is RegisterCredentialState ) {
      return emit(
        currentState.copyWith(
          obscurePassword: !currentState.obscurePassword,
        ),
      );
    }
  }

  void toggleConfirmPwdVisibility() {
    final currentState = state;
    if ( currentState is RegisterCredentialState ) {
      return emit(
        currentState.copyWith(
          obscureConfirmPassword: !currentState.obscureConfirmPassword,
        ),
      );
    }
  }

  Future<void> validateCredentialsFields() async {
    final currentState = state as RegisterCredentialState;
    if ( !currentState.formKey.currentState!.validate() ) {
      return showError("toast.error.invalid_fields_red_validations");
    }

    emit(RegisterLoadingState());

    final user = UserEntity.register(
      currentState.nameController.text.trim(),
      currentState.emailController.text.trim(),
      currentState.defaultCoin,
    );

    final response = await _authUseCase.registerUserWithEmail(user, currentState.passwordController.text.trim());
    response.fold(
      (failure) {
        showError(failure.message);
        emit(RegisterCredentialState());
      },
      (user) async {
        currentState.dispose();
        showSuccess("toast.success.user_created");
        return await _getDefaultCategories();
      },
    );
  }

  /// ***********************
  /// SELEÇÃO DAS CATEGORIAS PRINCIPAIS
  /// ***********************

  void toggleCategorySelection( CategoryEntity category ) {
    final currentState = state;
    if ( currentState is RegisterCategoriesState ) {

      category = category.copyWith(isSelected: !category.isSelected);

      final categories = List<CategoryEntity>.from(currentState.categories);
      final selectedCategoryIndex = categories.indexWhere((element) => element.id == category.id);
      if ( !selectedCategoryIndex.isNegative ) {
        categories[selectedCategoryIndex] = category;
      }

      return emit(
        currentState.copyWith(
          categories: categories,
        ),
      );

    }
  }

  Future<void> validateCategoriesSelection() async {
    final currentState = state as RegisterCategoriesState;

    final categories = List<CategoryEntity>.from(currentState.categories);

    final revenueCategory = categories.firstWhere((category) => category.isRevenue && category.isSelected, orElse: () => CategoryEntity.empty());
    final essentialCategory = categories.firstWhere((category) => category.isEssentialExpense && category.isSelected, orElse: () => CategoryEntity.empty());

    if ( revenueCategory.id.trim().isEmpty || essentialCategory.id.trim().isEmpty ) {
      return showError("toast.error.categories");
    }

    final registerCategoriesState = state as RegisterCategoriesState;
    emit(RegisterLoadingState());

    final selectedCategories = List<CategoryEntity>.from(registerCategoriesState.categories);
    selectedCategories.retainWhere((category) => category.isSelected);

    final response = await _categoryUseCase.createUserCategories(selectedCategories);
    response.fold(
      (failure) {
        showError(failure.message);
        emit(RegisterCategoriesState(categories: registerCategoriesState.categories));
      },
      (categories) async {
        showSuccess("toast.success.categories_created");
        emit(
          RegisterCategoriesSelectedState(
            categories: categories,
            coins: coins,
          ),
        );

        return registerCategoriesState.dispose();
      },
    );
  }

  /// ***********************
  /// ATUALIZAÇÃO DO VALOR LIMITE DAS CATEGORIAS
  /// ***********************

  void toggleDefaultCoinUpdSelectedCategory( CategoryEntity category ) {
    final currentState = state;
    if ( currentState is RegisterCategoriesSelectedState ) {

      category = category.copyWith(isDefaultCoin: !category.isDefaultCoin, coin: currentState.getDefaultCoin());

      final categories = List<CategoryEntity>.from(currentState.categories);
      final selectedCategoryIndex = categories.indexWhere((element) => element.id == category.id);
      if ( !selectedCategoryIndex.isNegative ) {
        categories[selectedCategoryIndex] = category;
      }

      return emit(
        currentState.copyWith(
          controllers: _manageCategoriesController(categories),
          categories: categories,
        ),
      );

    }
  }

  void updateValueLimitCategory( String categoryId, String newValueLimit ) {
    final currentState = state;
    if ( currentState is RegisterCategoriesSelectedState ) {

      final parsedNewValueLimit = Session.coinFormatter.coinToDouble(newValueLimit);

      final updatedCategories = currentState.categories.map((category) {
        if ( category.id == categoryId ) {
          category = category.copyWith(valueLimit: parsedNewValueLimit);
        }
        return category;
      }).toList();

      emit(
        currentState.copyWith(
          categories: updatedCategories,
        ),
      );

    }
  }

  Map<String, MoneyMaskedTextController> _manageCategoriesController( List<CategoryEntity> categories ) {
    final Map<String, MoneyMaskedTextController> controllers = {};

    for ( final category in categories ) {
      controllers[category.id] = Session.fieldsFormatter.moneyController(
        category.valueLimit,
        leftSymbol: category.coinSymbol.trim().isEmpty ? null : "${category.coinSymbol} ",
        thousandSeparator: category.thousandSeparator.trim().isEmpty ? null : category.thousandSeparator,
        decimalSeparator: category.decimalSeparator.trim().isEmpty ? null : category.decimalSeparator,
      );
    }

    return controllers;
  }

  /// ***********************
  /// REGISTRO DA CONTA
  /// ***********************

  void toggleTypeAccountSelection( TypeAccountEntity typeAccount ) {
    final currentState = state;
    if ( currentState is RegisterAccountsState ) {

      typeAccount = typeAccount.copyWith(isSelected: !typeAccount.isSelected);

      final list = List<TypeAccountEntity>.from(currentState.typeAccounts);
      final oldIndexSelectedItem = list.indexWhere((item) => item.isSelected);
      if ( !oldIndexSelectedItem.isNegative ) {
        final oldItem = list[oldIndexSelectedItem];
        list[oldIndexSelectedItem] = oldItem.copyWith(isSelected: !oldItem.isSelected);
      }

      final typeAccountIndex = list.indexWhere((element) => element.id == typeAccount.id);
      if ( !typeAccountIndex.isNegative ) {
        list[typeAccountIndex] = typeAccount;
      }

      return emit(
        currentState.copyWith(
          typeAccounts: list,
        ),
      );

    }
  }

  Future<void> validateUpdSelectedCategories() async {
    if ( !Session.formKey.currentState!.validate() ) {
      return showError("toast.error.invalid_fields_red_validations");
    }

    final currentState = state as RegisterCategoriesSelectedState;
    emit(RegisterLoadingState());

    final response = await _categoryUseCase.updateUserCategories(currentState.categories);
    response.fold(
      (failure) {
        showError(failure.message);
        emit(
          RegisterCategoriesSelectedState(
            controllers: currentState.controllers,
            categories: currentState.categories,
            coins: currentState.coins,
          ),
        );
      },
      (success) {
        currentState.dispose();
        showSuccess("toast.success.categories_updated");
        return emit(
          RegisterAccountsState(
            coins: coins,
          ),
        );
      },
    );
  }

  Future<void> validateAndRegisterAccount() async {
    final currentState = state as RegisterAccountsState;
    if ( !Session.formKey.currentState!.validate() ) {
      return showError("toast.error.invalid_fields_red_validations");
    }
    
    final list = List<TypeAccountEntity>.of(currentState.typeAccounts);
    list.retainWhere((item) => item.isSelected);
    
    if ( list.isEmpty ) {
      return showError("validations.required.type_account");
    }

    emit(RegisterLoadingState());

    final account = AccountEntity.createAccount(currentState.nameController.text, currentState.amountController.text, currentState.defaultCoin, list.first, isDefaultAccount: true);

    final response = await _accountUseCase.createUserAccount(account);
    response.fold(
      (failure) {
        showError(failure.message);
        emit(
          RegisterAccountsState(
            nameController: currentState.nameController,
            amountController: currentState.amountController,
            typeAccounts: currentState.typeAccounts,
            defaultCoin: currentState.defaultCoin,
            coins: coins,
          ),
        );
      },
      (account) {
        currentState.dispose();
        showSuccess("toast.success.account_created");
        return emit(
          RegisterCardState(
            account: account,
          ),
        );
      },
    );
  }

  /// ***********************
  /// CRIAÇÃO DO CARTÃO
  /// ***********************

  Future<void> skipCreditCard() async {
    emit(RegisterLoadingState());

    final response = await _userUseCase.updateUser(Session.user);
    response.fold(
      (failure) => _goToDashboard(),
      (success) => _goToDashboard(),
    );
  }

  Future<void> validateAndRegisterCard() async {
    final currentState = state as RegisterCardState;
    if ( !Session.formKey.currentState!.validate() ) {
      return showError("toast.error.invalid_fields_red_validations");
    }

    emit(RegisterLoadingState());
    
    final card = CardEntity(
      name: currentState.nameController.text,
      accountId: currentState.account.id,
      instatementAmount: "0",
      valueLimit: currentState.limitController.text,
      valueSpent: "0",
      percentage: "0",
      coinSymbol: Session.user.coinSymbol,
      thousandSeparator: Session.user.thousandSeparator,
      decimalSeparator: Session.user.decimalSeparator,
    );

    final response = await _cardUseCase.createCard(card);
    response.fold(
      (failure) => _goToDashboard(),
      (success) => _goToDashboard(),
    );
    
  }

  void _goToDashboard() => Session.navigation.go(DashPath().dashboard);
}