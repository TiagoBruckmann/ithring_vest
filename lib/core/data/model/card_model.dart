import 'package:equatable/equatable.dart';
import 'package:ithring_vest/core/domain/entities/card_entity.dart';
import 'package:ithring_vest/session.dart';

class CardModel extends CardEntity with EquatableMixin {
  CardModel({ required super.name, required super.accountId, required super.coinSymbol, required super.thousandSeparator, required super.decimalSeparator, required super.instatementAmount, required super.valueLimit, required super.valueSpent, required super.percentage, super.id, super.isActive });

  factory CardModel.fromJson( Map<String, dynamic> json ) {
    return CardModel(
      id: json["id"],
      accountId: json["account_id"],
      name: json["name"],
      valueLimit: Session.coinFormatter.doubleToCoin(json["value_limit"]),
      valueSpent: Session.coinFormatter.doubleToCoin(json["value_spent"]),
      instatementAmount: Session.coinFormatter.doubleToCoin(json["installment_amount"]),
      percentage: Session.coinFormatter.doubleToPercentage(json["percentage"]),
      isActive: json["is_active"],
      coinSymbol: json["coin_symbol"],
      thousandSeparator: json["thousand_separator"],
      decimalSeparator: json["decimal_separator"],
    );
  }

  factory CardModel.fromEntity( CardEntity entity ) {
    String id = entity.id;
    if ( id.trim().isEmpty ) {
      id = Session.utils.getRandomString(20);
    }

    return CardModel(
      id: id,
      name: entity.name,
      accountId: entity.accountId,
      instatementAmount: entity.instatementAmount,
      valueLimit: entity.valueLimit,
      valueSpent: entity.valueSpent,
      percentage: entity.percentage,
      isActive: entity.isActive,
      coinSymbol: entity.coinSymbol,
      thousandSeparator: entity.thousandSeparator,
      decimalSeparator: entity.decimalSeparator,
    );
  }
  
}