import 'package:equatable/equatable.dart';
import 'package:ithring_vest/core/domain/entities/user_entity.dart';

class UserModel extends UserEntity with EquatableMixin {
  UserModel({required super.id, required super.photoUrl, required super.name, required super.email, required super.coinSymbol, required super.thousandSeparator, required super.decimalSeparator, required super.stepMissing, required super.financialBalance, required super.settings, required super.oldBalance, required super.isRegisterFinished });

  factory UserModel.fromJson( Map<String, dynamic> json ) {
    return UserModel(
      id: json["id"],
      photoUrl: json["photo_url"],
      name: json["name"],
      email: json["email"],
      coinSymbol: json["coin_symbol"],
      thousandSeparator: json["thousand_separator"],
      decimalSeparator: json["decimal_separator"],
      stepMissing: json["step_missing"],
      financialBalance: UserFinancialBalanceModel.fromJson(json["financial_balance"]),
      settings: UserSettingsModel.fromJson(json["settings"]),
      oldBalance: json["old_balance"],
      isRegisterFinished: json["is_register_finished"],
    );
  }

  factory UserModel.fromEntity( UserEntity user ) {
    return UserModel(
      id: "",
      photoUrl: "",
      name: user.name,
      email: user.email,
      coinSymbol: user.coinSymbol,
      thousandSeparator: user.thousandSeparator,
      decimalSeparator: user.decimalSeparator,
      stepMissing: user.stepMissing,
      financialBalance: UserFinancialBalanceModel.fromEntity(user.financialBalance),
      settings: UserSettingsModel.fromEntity(user.settings),
      oldBalance: user.oldBalance,
      isRegisterFinished: user.isRegisterFinished,
    );
  }

  UserModel setRegisterData( String id ) {
    return UserModel(
      id: id,
      photoUrl: "https://ui-avatars.com/api/?name=$name",
      name: name,
      email: email,
      coinSymbol: coinSymbol,
      thousandSeparator: thousandSeparator,
      decimalSeparator: decimalSeparator,
      stepMissing: stepMissing,
      financialBalance: financialBalance,
      settings: settings,
      oldBalance: oldBalance,
      isRegisterFinished: isRegisterFinished,
    );
  }

}

class UserFinancialBalanceModel extends UserFinancialBalanceEntity with EquatableMixin {
  UserFinancialBalanceModel(super.essentialExpenses, super.nonEssentialExpenses, super.investments);

  factory UserFinancialBalanceModel.fromJson( Map<String, dynamic> json ) {
    return UserFinancialBalanceModel(
      json["essential_expenses"],
      json["non_essential_expenses"],
      json["investments"],
    );
  }

  factory UserFinancialBalanceModel.fromEntity( UserFinancialBalanceEntity entity ) {
    return UserFinancialBalanceModel(
      entity.essentialExpenses,
      entity.nonEssentialExpenses,
      entity.investments,
    );
  }

}

class UserSettingsModel extends UserSettingsEntity with EquatableMixin {
  UserSettingsModel( super.qtdMonthsEmergencyReserve );

  factory UserSettingsModel.fromJson( Map<String, dynamic> json ) {
    return UserSettingsModel(
      json["qtd_months_emergency_reserve"],
    );
  }

  factory UserSettingsModel.fromEntity( UserSettingsEntity entity ) {
    return UserSettingsModel(
      entity.qtdMonthsEmergencyReserve,
    );
  }

}