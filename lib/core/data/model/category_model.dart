import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ithring_vest/core/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity with EquatableMixin {
  CategoryModel(super.id, super.name, super.icon, super.isRevenue, super.isEssentialExpense, super.valueLimit, super.valueSpent, super.percentage, { super.coinSymbol = "", super.thousandSeparator = "", super.decimalSeparator = "" });

  factory CategoryModel.fromJson( Map<String, dynamic> json ) {
    return CategoryModel(
      json["id"],
      json["name"],
      _buildIcon(json["icon"], json["icon_color"], json["icon_font_family"]),
      json["is_revenue"],
      json["is_essential_expense"],
      json["value_limit"],
      json["value_spent"],
      json["percentage"],
      coinSymbol: json["coin_symbol"],
      thousandSeparator: json["thousand_separator"],
      decimalSeparator: json["decimal_separator"],
    );
  }

  static Icon _buildIcon( int iconName, int iconColor, String iconFontFamily ) {
    return Icon(
      IconData(
        iconName,
        fontFamily: iconFontFamily,
      ),
      color: Color(iconColor),
    );
  }

}