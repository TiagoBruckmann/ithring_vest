import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {

  final String id, photo, name, email, defaultCoin, currencyFormat, stepMissing;
  final UserFinancialBalanceEntity financialBalance;
  final double oldBalance;
  final bool isRegisterFinished;

  const UserEntity({
    required this.id,
    required this.photo,
    required this.name,
    required this.email,
    required this.defaultCoin,
    required this.currencyFormat,
    required this.stepMissing,
    required this.financialBalance,
    required this.oldBalance,
    required this.isRegisterFinished,
  });

  factory UserEntity.empty() => UserEntity(
    id: "",
    photo: "",
    name: "",
    email: "",
    defaultCoin: "",
    currencyFormat: "",
    stepMissing: "",
    financialBalance: UserFinancialBalanceEntity.empty(),
    oldBalance: 0,
    isRegisterFinished: false,
  );

  Map<String, dynamic> registerUserToJson( String password ) {
    Map<String, dynamic> map = {
      "name": name,
      "email": email,
      "password": password,
      "default_coin" : defaultCoin,
      "step_missing" : stepMissing,
      "financial_balance": financialBalance.save(),
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
      "default_coin" : defaultCoin,
      "financial_balance": financialBalance.save(),
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
  String toString() => "UserEntity($id, $name, $defaultCoin)";

  @override
  List<Object?> get props => [id, name, photo, email, defaultCoin, currencyFormat, financialBalance, oldBalance];

}

class UserFinancialBalanceEntity extends Equatable {
  final double essentialExpenses, nonEssentialExpenses, investments;

  const UserFinancialBalanceEntity( this.essentialExpenses, this.nonEssentialExpenses, this.investments );

   factory UserFinancialBalanceEntity.empty() => const UserFinancialBalanceEntity(0, 0, 0);

   Map<String, dynamic> save() {
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