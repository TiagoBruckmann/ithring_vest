import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import 'package:ithring_vest/core/domain/entities/category_entity.dart';
import 'package:ithring_vest/core/domain/entities/coin_entity.dart';
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

  Future<void> _getInitialData() async {
    emit(RegisterLoadingState());

    if ( Session.user.stepMissing == StepMissingEnum.categories.name ) {
      return await _getCategories();
    }

    if ( Session.user.stepMissing == StepMissingEnum.accounts.name ) {
      return emit(RegisterAccountsState());
    }

    if ( Session.user.stepMissing == StepMissingEnum.creditCard.name ) {
      return emit(RegisterCardState());
    }

    await _getCoins();
  }

  Future<void> _getCoins() async {
    final result = await _coinUseCase.getCoins();
    result.fold(
      (failure) {
        return emit(
          RegisterCredentialState(
            coins: [CoinEntity.defaultBrl()],
            defaultCoin: CoinEntity.defaultBrl(),
          ),
        );
      },
      (coins) {
        return emit(
          RegisterCredentialState(
            coins: coins,
            defaultCoin: CoinEntity.defaultBrl(),
          ),
        );
      },
    );
  }

  Future<void> _getCategories() async {
    final result = await _categoryUseCase.getDefaultCategories();
    result.fold(
      (failure) {
        showError("toast.error.categories_not_loaded");
        return emit(RegisterCredentialState());
      },
      (categories) => emit(RegisterCategoriesState(categories: categories)),
    );
  }

  void selectCoin( CoinEntity coin ) {
    final currentState = state;
    if ( currentState is RegisterCredentialState ) {
      return emit(
        currentState.copyWith(
          defaultCoin: coin,
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
        showSuccess("toast.success.user_created");
        return await _getCategories();
      },
    );

  }

  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }

}