import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import 'package:ithring_vest/core/domain/entities/category_entity.dart';
import 'package:ithring_vest/core/domain/entities/coin_entity.dart';
import 'package:ithring_vest/core/domain/entities/type_account_entity.dart';
import 'package:ithring_vest/core/domain/entities/user_entity.dart';
import 'package:ithring_vest/core/domain/enums/step_missing_enum.dart';
import 'package:ithring_vest/core/domain/usecases/auth_use_case.dart';
import 'package:ithring_vest/core/domain/usecases/category_use_case.dart';
import 'package:ithring_vest/core/domain/usecases/coin_use_case.dart';
import 'package:ithring_vest/design_system/widgets/toast_widget.dart';
import 'package:ithring_vest/session.dart';

part 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final CategoryUseCase _categoryUseCase;
  final AuthUseCase _authUseCase;
  final CoinUseCase _coinUseCase;
  RegisterCubit(
    this._categoryUseCase,
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
      return emit(RegisterAccountsState());
    }

    if ( Session.user.stepMissing == StepMissingEnum.creditCard.name ) {
      return emit(RegisterCardState());
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
    /// TODO: TROCAR O USE CASE
    final result = await _categoryUseCase.getDefaultTypeAccounts();
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
  }

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

  void validateCredentialsFields() {
    final currentState = state as RegisterCredentialState;
    if ( !currentState.formKey.currentState!.validate() ) {
      return showError("toast.error.invalid_fields_red_validations");
    }

    _registerUser();
  }

  Future<void> _registerUser() async {
    final currentState = state as RegisterCredentialState;
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

  void validateCategoriesSelection() {
    final currentState = state as RegisterCategoriesState;

    final categories = List<CategoryEntity>.from(currentState.categories);

    final revenueCategory = categories.firstWhere((category) => category.isRevenue && category.isSelected, orElse: () => CategoryEntity.empty());
    final essentialCategory = categories.firstWhere((category) => category.isEssentialExpense && category.isSelected, orElse: () => CategoryEntity.empty());

    if ( revenueCategory.id.trim().isEmpty || essentialCategory.id.trim().isEmpty ) {
      return showError("toast.error.categories");
    }

    _registerUserCategories();
  }

  Future<void> _registerUserCategories() async {
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

  void validateUpdSelectedCategories() {
    if ( !Session.formKey.currentState!.validate() ) {
      return showError("toast.error.invalid_fields_red_validations");
    }

    _updSelectedCategories();
  }

  Future<void> _updSelectedCategories() async {
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

  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }

}