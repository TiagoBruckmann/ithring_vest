import 'package:equatable/equatable.dart';
import 'package:ithring_vest/core/domain/entities/user_entity.dart';
import 'package:ithring_vest/session.dart';

class UserModel extends UserEntity with EquatableMixin {
  UserModel({required super.id, required super.photo, required super.name, required super.email, required super.defaultCoin, required super.currencyFormat, required super.stepMissing, required super.financialBalance, required super.oldBalance, required super.isRegisterFinished});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final coin = json["default_coin"];

    return UserModel(
      id: json["id"],
      photo: json["photo"],
      name: json["name"],
      email: json["email"],
      defaultCoin: coin,
      currencyFormat: Session.coinFormatter.currencyFormat(coin),
      stepMissing: json["step_missing"],
      financialBalance: json["financial_balance"],
      oldBalance: json["old_balance"],
      isRegisterFinished: json["is_register_finished"],
    );
  }

}