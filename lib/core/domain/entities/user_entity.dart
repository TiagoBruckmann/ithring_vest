import 'package:equatable/equatable.dart';
import 'package:ithring_vest/core/domain/entities/coin_entity.dart';
import 'package:ithring_vest/core/domain/enums/step_missing_enum.dart';
import 'package:ithring_vest/session.dart';

class UserEntity extends Equatable {

  final String id, photoUrl, name, email, coinSymbol, thousandSeparator, decimalSeparator, stepMissing;
  final UserFinancialBalanceEntity financialBalance;
  final UserSettingsEntity settings;
  final num oldBalance;
  final bool isRegisterFinished;
  final UserFinancialHealth financialHealth;

  const UserEntity({
    required this.id,
    required this.photoUrl,
    required this.name,
    required this.email,
    required this.coinSymbol,
    required this.thousandSeparator,
    required this.decimalSeparator,
    required this.stepMissing,
    required this.financialBalance,
    required this.settings,
    required this.oldBalance,
    required this.isRegisterFinished,
    this.financialHealth = const UserFinancialHealth("", 0),
  });

  factory UserEntity.empty() {
    return UserEntity(
      id: "",
      photoUrl: "",
      name: "",
      email: "",
      coinSymbol: "",
      thousandSeparator: "",
      decimalSeparator: "",
      stepMissing: "",
      financialBalance: UserFinancialBalanceEntity.default503020(),
      settings: UserSettingsEntity.defaultSettings(),
      oldBalance: 0,
      isRegisterFinished: false,
    );
  }

  factory UserEntity.register( String name, String email, CoinEntity coin ) {
    return UserEntity(
      id: "",
      photoUrl: "",
      name: name,
      email: email,
      coinSymbol: coin.symbol,
      thousandSeparator: coin.thousandSeparator,
      decimalSeparator: coin.decimalSeparator,
      stepMissing: StepMissingEnum.categories.name,
      financialBalance: UserFinancialBalanceEntity.default503020(),
      settings: UserSettingsEntity.defaultSettings(),
      oldBalance: 0,
      isRegisterFinished: false,
    );
  }

  UserEntity copyWith({
    UserFinancialHealth? financialHealth,
  }) {
    return UserEntity(
      id: id,
      photoUrl: photoUrl,
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
      financialHealth: financialHealth ?? this.financialHealth,
    );
  }

  Map<String, dynamic> registerUserToJson( String userId ) {
    Map<String, dynamic> map = {
      "id": userId,
      "name": name,
      "photo_url": photoUrl,
      "email": email,
      "coin_symbol" : coinSymbol,
      "thousand_separator" : thousandSeparator,
      "decimal_separator" : decimalSeparator,
      "step_missing" : stepMissing,
      "financial_balance": financialBalance.register503020(),
      "settings": settings.registerDefault(),
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
      "photo_url" : photoUrl,
      "name" : name,
      "email" : email,
      "coin_symbol" : coinSymbol,
      "thousand_separator" : thousandSeparator,
      "decimal_separator" : decimalSeparator,
      "financial_balance": financialBalance.update(),
      "settings": settings.update(),
      "old_balance": oldBalance,
      "updated_at": DateTime.now().toIso8601String(),
    };

    return map;
  }

  Map<String, dynamic> updStatusRegisterJson() {

    String stepMissing = "";
    if ( Session.user.stepMissing.trim() == StepMissingEnum.categories.name ) {
      stepMissing = StepMissingEnum.categoriesSelected.name;
    } else if ( Session.user.stepMissing.trim() == StepMissingEnum.categoriesSelected.name ) {
      stepMissing = StepMissingEnum.accounts.name;
    } else if ( Session.user.stepMissing.trim() == StepMissingEnum.accounts.name ) {
      stepMissing = StepMissingEnum.creditCard.name;
    }

    Map<String, dynamic> map = {
      "step_missing" : stepMissing,
      "is_register_finished" : stepMissing.trim().isEmpty,
      "updated_at": DateTime.now().toIso8601String(),
    };

    return map;
  }

  @override
  String toString() => "UserEntity($id, $name, $coinSymbol)";

  @override
  List<Object?> get props => [id, name, photoUrl, email, coinSymbol, thousandSeparator, decimalSeparator, financialBalance, settings, oldBalance, isRegisterFinished, stepMissing, financialHealth];

}

class UserFinancialBalanceEntity extends Equatable {
  final num essentialExpenses, nonEssentialExpenses, investments;

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

class UserSettingsEntity extends Equatable {
  final int qtdMonthsEmergencyReserve;

  const UserSettingsEntity( this.qtdMonthsEmergencyReserve );

   factory UserSettingsEntity.defaultSettings() => const UserSettingsEntity(6);

   Map<String, dynamic> registerDefault() {
    Map<String, dynamic> map = {
      "qtd_months_emergency_reserve": 6,
    };

    return map;
  }

   Map<String, dynamic> update() {
    Map<String, dynamic> map = {
      "qtd_months_emergency_reserve": qtdMonthsEmergencyReserve,
    };

    return map;
  }

  @override
  String toString() => "UserSettingsEntity(qtdMonthsEmergencyReserve: $qtdMonthsEmergencyReserve)";

  @override
  List<Object?> get props => [qtdMonthsEmergencyReserve];

}

class UserFinancialHealth extends Equatable {
  final String name;
  final int percentage;
  final String? detailedMessage;

  const UserFinancialHealth( this.name, this.percentage, { this.detailedMessage });

   factory UserFinancialHealth.empty() => const UserFinancialHealth("", 0);

  UserFinancialHealth copyWith({
    String? name,
    int? percentage,
    String? detailedMessage,
  }) {
    return UserFinancialHealth(
      name ?? this.name,
      percentage ?? this.percentage,
      detailedMessage: detailedMessage ?? this.detailedMessage,
    );
  }

  @override
  String toString() => "UserFinancialHealth(name: $name, percentage: $percentage, detailedMessage: $detailedMessage)";

  @override
  List<Object?> get props => [name, percentage, detailedMessage];

}