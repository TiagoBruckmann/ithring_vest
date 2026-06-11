import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ithring_vest/core/domain/entities/coin_entity.dart';
import 'package:ithring_vest/session.dart';

class CategoryEntity extends Equatable {

  final String id, name, coinSymbol, thousandSeparator, decimalSeparator;
  final Icon icon;
  final double valueLimit, valueSpent, percentage;
  final bool isEssentialExpense, isRevenue, isSelected;
  final bool isDefaultCoin;
  final String? coinAcronym;

  const CategoryEntity(
    this.id, this.name, this.icon, this.isRevenue,
    this.isEssentialExpense, this.valueLimit, this.valueSpent,
    this.percentage,
    {
      this.coinSymbol = "", this.thousandSeparator = "", this.decimalSeparator = "", this.isSelected = false,
      this.isDefaultCoin = true, this.coinAcronym,
    }
  );

  CategoryEntity.empty() : id = "", name = "", coinSymbol = "", thousandSeparator = "", decimalSeparator = "", icon = Icon(Icons.auto_graph_rounded), isRevenue = false, isEssentialExpense = false, valueLimit = 0, valueSpent = 0, percentage = 0, isSelected = false, isDefaultCoin = true, coinAcronym = "BRL";

  CategoryEntity copyWith({
    double? valueLimit,
    bool? isSelected,
    bool? isDefaultCoin,
    CoinEntity? coin,
  }) {
    return CategoryEntity(
      id,
      name,
      icon,
      isRevenue,
      isEssentialExpense,
      valueLimit ?? this.valueLimit,
      valueSpent,
      percentage,
      isSelected: isSelected ?? this.isSelected,
      isDefaultCoin: isDefaultCoin ?? this.isDefaultCoin,
      coinAcronym: coin?.acronym ?? coinAcronym,
      coinSymbol: coin?.symbol ?? coinSymbol,
      thousandSeparator: coin?.thousandSeparator ?? thousandSeparator,
      decimalSeparator: coin?.decimalSeparator ?? decimalSeparator,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "coin_symbol": coinSymbol,
      "thousand_separator": thousandSeparator,
      "decimal_separator": decimalSeparator,
      "icon": icon.icon!.codePoint,
      "icon_font_family": icon.icon!.fontFamily,
      "icon_color": icon.color!.toARGB32(),
      "value_limit": valueLimit,
      "value_spent": valueSpent,
      "percentage": percentage,
      "is_essential_expense": isEssentialExpense,
      "is_revenue": isRevenue,
      "created_at": DateTime.now().toIso8601String(),
    };
  }

  Map<String, dynamic> updateJson() {

    String coinSymbol = this.coinSymbol;
    String thousandSeparator = this.thousandSeparator;
    String decimalSeparator = this.decimalSeparator;
    if ( coinSymbol.trim().isEmpty ) {
      coinSymbol = Session.user.coinSymbol;
      thousandSeparator = Session.user.thousandSeparator;
      decimalSeparator = Session.user.decimalSeparator;
    }

    return {
      "coin_symbol": coinSymbol,
      "thousand_separator": thousandSeparator,
      "decimal_separator": decimalSeparator,
      "value_limit": valueLimit,
      "value_spent": valueSpent,
      "percentage": percentage,
      "updated_at": DateTime.now().toIso8601String(),
    };
  }

  @override
  String toString() => "CategoryEntity($id, $name, isRevenue: $isRevenue, isEssentialExpense: $isEssentialExpense)";

  @override
  List<Object?> get props => [
    id,
    name,
    coinSymbol,
    thousandSeparator,
    decimalSeparator,
    icon,
    isRevenue,
    isEssentialExpense,
    valueLimit,
    valueSpent,
    percentage,
    isSelected,
    isDefaultCoin,
  ];

}