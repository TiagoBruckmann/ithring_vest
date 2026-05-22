import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ithring_vest/core/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity with EquatableMixin {
  CategoryModel(super.id, super.name, super.icon, super.isRevenue, super.isEssentialExpense, super.valueLimit, super.valueSpent, super.percentage);

  factory CategoryModel.fromJson( Map<String, dynamic> json ) {
    return CategoryModel(
      json["id"],
      json["name"],
      _getIconFromString(json["icon"], json["icon_color"]),
      json["is_revenue"],
      json["is_essential_expense"],
      json["value_limit"],
      json["value_spent"],
      json["percentage"],
    );
  }

  static Icon _getIconFromString( String iconName, String iconColor ) {
    Map<String, IconData> icons = {
      "home_rounded": Icons.home_rounded,
      "account_balance_rounded": Icons.account_balance_rounded,
      "restaurant_rounded": Icons.restaurant_rounded,
      "directions_car_filled_rounded": Icons.directions_car_filled_rounded,
      "favorite_rounded": Icons.favorite_rounded,
      "school_rounded": Icons.school_rounded,
      "shield_rounded": Icons.shield_rounded,
      "sports_esports_rounded": Icons.sports_esports_rounded,
      "subscriptions_rounded": Icons.subscriptions_rounded,
      "flight_takeoff_rounded": Icons.flight_takeoff_rounded,
      "pets_rounded": Icons.pets_rounded,
      "redeem_rounded": Icons.redeem_rounded,
      "work_rounded": Icons.work_rounded,
      "show_chart_rounded": Icons.show_chart_rounded,
      "apartment_rounded": Icons.apartment_rounded,
      "public_rounded": Icons.public_rounded,
      "language_rounded": Icons.language_rounded,
      "currency_bitcoin_rounded": Icons.currency_bitcoin_rounded,
      "security_rounded": Icons.security_rounded,
      "hourglass_bottom_rounded": Icons.hourglass_bottom_rounded,
      "payments_rounded": Icons.payments_rounded,
      "arrow_circle_up_rounded": Icons.arrow_circle_up_rounded,
      "auto_graph_rounded": Icons.auto_graph_rounded,
    };

    return Icon(
      icons[iconName] ?? Icons.auto_graph_rounded,
      color: Color(_parseHexColor(iconColor.trim())),
    );
  }

  static int _parseHexColor( String hexColor ) {
    if ( hexColor.startsWith('0x') ) {
      hexColor = hexColor.substring(2);
    } else if ( hexColor.startsWith('#') ) {
      hexColor = hexColor.substring(1);
    }

    if ( hexColor.length != 8 ) {
      return 0xFFFADA28;
    }

    return int.parse(hexColor, radix: 16);
  }

}