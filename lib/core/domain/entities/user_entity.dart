import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:ithring_vest/core/domain/entities/coin_entity.dart';
import 'package:ithring_vest/core/domain/enums/step_missing_enum.dart';

class UserEntity extends Equatable {

  final String id, photo, name, email, coinSymbol, thousandSeparator, decimalSeparator, stepMissing;
  final UserFinancialBalanceEntity financialBalance;
  final double oldBalance;
  final bool isRegisterFinished;

  const UserEntity({
    required this.id,
    required this.photo,
    required this.name,
    required this.email,
    required this.coinSymbol,
    required this.thousandSeparator,
    required this.decimalSeparator,
    required this.stepMissing,
    required this.financialBalance,
    required this.oldBalance,
    required this.isRegisterFinished,
  });

  factory UserEntity.empty() {
    return UserEntity(
      id: "",
      photo: "",
      name: "",
      email: "",
      coinSymbol: "",
      thousandSeparator: "",
      decimalSeparator: "",
      stepMissing: "",
      financialBalance: UserFinancialBalanceEntity.default503020(),
      oldBalance: 0,
      isRegisterFinished: false,
    );
  }

  factory UserEntity.register( String name, String email, CoinEntity coin ) {
    return UserEntity(
      id: "",
      photo: "",
      name: name,
      email: email,
      coinSymbol: coin.symbol,
      thousandSeparator: coin.thousandSeparator,
      decimalSeparator: coin.decimalSeparator,
      stepMissing: StepMissingEnum.categories.name,
      financialBalance: UserFinancialBalanceEntity.default503020(),
      oldBalance: 0,
      isRegisterFinished: false,
    );
  }

  Map<String, dynamic> registerUserToJson() {
    Map<String, dynamic> map = {
      "name": name,
      "email": email,
      "coin_symbol" : coinSymbol,
      "thousand_separator" : thousandSeparator,
      "decimal_separator" : decimalSeparator,
      "step_missing" : stepMissing,
      "financial_balance": financialBalance.register503020(),
      "old_balance": oldBalance,
      "is_register_finished": isRegisterFinished,
      "created_at": DateTime.now().toIso8601String(),
      "updated_at": "",
    };

    return map;
  }

  Map<String, dynamic> updUserToJson() {
    Map<String, dynamic> map = {
      "id": id,
      "photo" : photo,
      "name" : name,
      "email" : email,
      "coin_symbol" : coinSymbol,
      "thousand_separator" : thousandSeparator,
      "decimal_separator" : decimalSeparator,
      "financial_balance": financialBalance.update(),
      "old_balance": oldBalance,
      "updated_at": DateTime.now().toIso8601String(),
    };

    return map;
  }

  Map<String, dynamic> updIsRegisterFinishedJson() {
    Map<String, dynamic> map = {
      "id": id,
      "step_missing" : "",
      "is_register_finished" : true,
      "updated_at": DateTime.now().toIso8601String(),
    };

    return map;
  }

  @override
  String toString() => "UserEntity($id, $name, $coinSymbol)";

  @override
  List<Object?> get props => [id, name, photo, email, coinSymbol, thousandSeparator, decimalSeparator, financialBalance, oldBalance];

}

class UserFinancialBalanceEntity extends Equatable {
  final double essentialExpenses, nonEssentialExpenses, investments;

  const UserFinancialBalanceEntity( this.essentialExpenses, this.nonEssentialExpenses, this.investments );

   factory UserFinancialBalanceEntity.default503020() => const UserFinancialBalanceEntity(50, 30, 20);

   Map<String, dynamic> register503020() {
    Map<String, dynamic> map = {
      "essential_expenses": 50,
      "non_essential_expenses" : 30,
      "investments" : 20,
    };

    return map;
  }

   Map<String, dynamic> update() {
    Map<String, dynamic> map = {
      "essential_expenses": essentialExpenses,
      "non_essential_expenses" : nonEssentialExpenses,
      "investments" : investments,
    };

    return map;
  }

  @override
  String toString() => "UserFinancialBalanceEntity(essentialExpenses: $essentialExpenses, nonEssentialExpenses: $nonEssentialExpenses, investments: $investments)";

  @override
  List<Object?> get props => [essentialExpenses, nonEssentialExpenses, investments];

}