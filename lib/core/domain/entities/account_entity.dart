import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ithring_vest/core/domain/entities/coin_entity.dart';
import 'package:ithring_vest/core/domain/entities/type_account_entity.dart';
import 'package:ithring_vest/session.dart';

class AccountEntity extends Equatable {

  final String id, name, typeAccount, amount, oldBalance, father;
  final bool isDefault, isBlocked;
  final double qtdStock;
  final Icon icon;
  final String? coinSymbol, thousandSeparator, decimalSeparator;
  final List<AccountEntity> children;

  const AccountEntity({
    required this.name, required this.typeAccount,
    required this.amount, required this.oldBalance, required this.isDefault,
    required this.isBlocked, required this.qtdStock, required this.icon,
    this.id = "", this.father = "", this.coinSymbol, this.thousandSeparator,
    this.decimalSeparator, this.children = const [],
  });

  const AccountEntity.empty() : id = "", name = "", coinSymbol = "", thousandSeparator = "", decimalSeparator = "", typeAccount = "", amount = "", oldBalance = "", father = "", isDefault = false, isBlocked = false, qtdStock = 0, icon = const Icon(Icons.auto_graph_rounded), children = const [];

  factory AccountEntity.createAccount( String name, String amount, CoinEntity coin, TypeAccountEntity typeAccount, { bool isDefaultAccount = false, double qtdStock = 0 }) {
    return AccountEntity(
      name: name,
      typeAccount: typeAccount.name,
      amount: amount,
      oldBalance: Session.fieldsFormatter.moneyController(0, leftSymbol: coin.symbol, thousandSeparator: coin.thousandSeparator, decimalSeparator: coin.decimalSeparator).text,
      isDefault: isDefaultAccount,
      isBlocked: false,
      qtdStock: qtdStock,
      icon: typeAccount.icon!,
      coinSymbol: coin.symbol,
      thousandSeparator: coin.thousandSeparator,
      decimalSeparator: coin.decimalSeparator,
    );
  }
  
  AccountEntity copyWith({
    String? name,
    CoinEntity? coin,
    String? typeAccount,
    bool? isDefault,
    bool? isBlocked,
    double? amount,
    double? oldBalance,
    double? qtdStock,
    Icon? icon,
    String? father,
  }) {

    String parsedAmount = this.amount;
    if ( amount != null ) {
      parsedAmount = Session.coinFormatter.doubleToCoin(amount);
    }

    String parsedOldBalance = this.oldBalance;
    if ( oldBalance != null ) {
      parsedOldBalance = Session.coinFormatter.doubleToCoin(oldBalance);
    }

    return AccountEntity(
      id: id,
      name: name ?? this.name,
      father: father ?? this.father,
      coinSymbol: coin?.symbol ?? coinSymbol,
      thousandSeparator: coin?.thousandSeparator ?? thousandSeparator,
      decimalSeparator: coin?.decimalSeparator ?? decimalSeparator,
      typeAccount: typeAccount ?? this.typeAccount,
      isDefault: isDefault ?? this.isDefault,
      isBlocked: isBlocked ?? this.isBlocked,
      amount: parsedAmount,
      oldBalance: parsedOldBalance,
      qtdStock: qtdStock ?? this.qtdStock,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": Session.user.id,
      "name": name,
      "coin_symbol": coinSymbol,
      "thousand_separator": thousandSeparator,
      "decimal_separator": decimalSeparator,
      "type_account": typeAccount,
      "is_default": isDefault,
      "is_blocked": isBlocked,
      "icon": icon.icon!.codePoint,
      "icon_font_family": icon.icon!.fontFamily,
      "icon_color": icon.color!.toARGB32(),
      "amount": Session.coinFormatter.coinToDouble(amount),
      "old_balance": Session.coinFormatter.coinToDouble(oldBalance),
      "qtd_stock": qtdStock,
      "father": father,
      "created_at": DateTime.now().toIso8601String(),
    };
  }

  Map<String, dynamic> updateAmountJson() {
    return {
      "id": id,
      "amount": Session.coinFormatter.coinToDouble(amount),
      "updated_at": DateTime.now().toIso8601String(),
    };
  }

  Map<String, dynamic> updateOldBalanceJson() {
    return {
      "id": id,
      "old_balance": Session.coinFormatter.coinToDouble(amount),
      "updated_at": DateTime.now().toIso8601String(),
    };
  }

  Map<String, dynamic> updateIsBlockedJson() {
    return {
      "id": id,
      "is_blocked": isBlocked,
      "updated_at": DateTime.now().toIso8601String(),
    };
  }

  Map<String, dynamic> updateIsDefaultJson() {
    return {
      "id": id,
      "is_default": isDefault,
      "updated_at": DateTime.now().toIso8601String(),
    };
  }

  Map<String, dynamic> updateQtdStockJson() {
    return {
      "id": id,
      "qtd_stock": qtdStock,
      "updated_at": DateTime.now().toIso8601String(),
    };
  }

  @override
  String toString() => "AccountEntity($id, $name)";

  @override
  List<Object?> get props => [
    id, name, typeAccount, amount, oldBalance, father, isDefault, isBlocked, qtdStock,
    icon, coinSymbol, thousandSeparator, decimalSeparator,
  ];

}