import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CategoryEntity extends Equatable {

  final String id, name, coinSymbol, thousandSeparator, decimalSeparator;
  final Icon icon;
  final double valueLimit, valueSpent, percentage;
  final bool isEssentialExpense, isRevenue;

  const CategoryEntity(
    this.id, this.name, this.icon, this.isRevenue,
    this.isEssentialExpense, this.valueLimit, this.valueSpent,
    this.percentage,
    {
      this.coinSymbol = "", this.thousandSeparator = "", this.decimalSeparator = "",
    }
  );

  CategoryEntity.empty() : id = "", name = "", coinSymbol = "", thousandSeparator = "", decimalSeparator = "", icon = Icon(Icons.auto_graph_rounded), isRevenue = false, isEssentialExpense = false, valueLimit = 0, valueSpent = 0, percentage = 0;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "coin_symbol": coinSymbol,
      "thousand_separator": thousandSeparator,
      "decimal_separator": decimalSeparator,
      "icon": icon.icon,
      "value_limit": valueLimit,
      "value_spent": valueSpent,
      "percentage": percentage,
      "is_essential_expense": isEssentialExpense,
      "is_revenue": isRevenue,
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
  ];

}