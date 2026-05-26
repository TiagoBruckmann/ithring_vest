import 'package:equatable/equatable.dart';
import 'package:ithring_vest/core/domain/entities/user_entity.dart';

class UserModel extends UserEntity with EquatableMixin {
  UserModel({required super.id, required super.photo, required super.name, required super.email, required super.coinSymbol, required super.thousandSeparator, required super.decimalSeparator, required super.stepMissing, required super.financialBalance, required super.oldBalance, required super.isRegisterFinished });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      photo: json["photo"],
      name: json["name"],
      email: json["email"],
      coinSymbol: json["coin_symbol"],
      thousandSeparator: json["thousand_separator"],
      decimalSeparator: json["decimal_separator"],
      stepMissing: json["step_missing"],
      financialBalance: UserFinancialBalanceModel.fromJson(json["financial_balance"]),
      oldBalance: json["old_balance"],
      isRegisterFinished: json["is_register_finished"],
    );
  }

}

class UserFinancialBalanceModel extends UserFinancialBalanceEntity with EquatableMixin {
  UserFinancialBalanceModel(super.essentialExpenses, super.nonEssentialExpenses, super.investments);

  factory UserFinancialBalanceModel.fromJson(Map<String, dynamic> json) {
    return UserFinancialBalanceModel(
      json["essential_expenses"],
      json["non_essential_expenses"],
      json["investments"],
    );
  }

}