import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import 'package:ithring_vest/core/domain/entities/coin_entity.dart';
import 'package:ithring_vest/design_system/widgets/toast_widget.dart';
import 'package:ithring_vest/session.dart';

part 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterCredentialState());

  final List<CoinEntity> coins = [];

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

  void validatePwd( String value ) {
    final currentState = state;
    if ( currentState is RegisterCredentialState ) {
      return emit(
        currentState.copyWith(
          isValidPassword: Session.fieldsValidation.isValidPassword(value),
        ),
      );
    }
  }

  void validateConfirmPwd( String value ) {
    final currentState = state;
    if ( currentState is RegisterCredentialState ) {
      return emit(
        currentState.copyWith(
          isValidConfirmPassword: Session.fieldsValidation.isValidPassword(value),
        ),
      );
    }
  }

  void validateCredentialsFields() {
    final currentState = state as RegisterCredentialState;
    if ( !currentState.formKey.currentState!.validate() ) {
      return showError("toast.error.invalid_fields_red_validations");
    }

  }

  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }

}