import 'package:equatable/equatable.dart';
import 'package:ithring_vest/core/domain/entities/coin_entity.dart';
import 'package:ithring_vest/session.dart';

class CardEntity extends Equatable {

  final String id, name, accountId, coinSymbol, thousandSeparator, decimalSeparator, instatementAmount, valueLimit, valueSpent, percentage;
  final bool isActive;

  const CardEntity({
    required this.name, required this.accountId, required this.coinSymbol,
    required this.thousandSeparator, required this.decimalSeparator,
    required this.instatementAmount, required this.valueLimit, required this.valueSpent,
    required this.percentage, this.id = "", this.isActive = true,
  });

  factory CardEntity.create( String name, String accountId, String valueLimit, CoinEntity coin ) {
    return CardEntity(
      name: name,
      accountId: accountId,
      coinSymbol: coin.symbol,
      thousandSeparator: coin.thousandSeparator,
      decimalSeparator: coin.decimalSeparator,
      instatementAmount: Session.fieldsFormatter.moneyController(0, leftSymbol: coin.symbol, thousandSeparator: coin.thousandSeparator, decimalSeparator: coin.decimalSeparator).text,
      valueLimit: valueLimit,
      valueSpent: Session.fieldsFormatter.moneyController(0, leftSymbol: coin.symbol, thousandSeparator: coin.thousandSeparator, decimalSeparator: coin.decimalSeparator).text,
      percentage: Session.coinFormatter.doubleToPercentage(0),
      isActive: true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": Session.user.id,
      "account_id": accountId,
      "name": name,
      "coin_symbol": coinSymbol,
      "thousand_separator": thousandSeparator,
      "decimal_separator": decimalSeparator,
      "installment_amount": Session.coinFormatter.coinToDouble(instatementAmount),
      "value_limit": Session.coinFormatter.coinToDouble(valueLimit),
      "value_spent": Session.coinFormatter.coinToDouble(valueSpent),
      "percentage": Session.coinFormatter.coinToDouble(percentage),
      "is_active": isActive,
      "created_at": DateTime.now().toIso8601String(),
    };
  }

  Map<String, dynamic> updateAmountJson() {
    final limit = Session.coinFormatter.coinToDouble(valueLimit);
    final installment = Session.coinFormatter.coinToDouble(instatementAmount);
    final spent = Session.coinFormatter.coinToDouble(valueSpent);

    return {
      "id": id,
      "installment_amount": installment,
      "value_limit": limit,
      "value_spent": spent,
      "percentage": Session.utils.percentageMathOperation(limit, spent),
      "updated_at": DateTime.now().toIso8601String(),
    };
  }

  @override
  String toString() => "CardEntity($id, $name)";

  @override
  List<Object?> get props => [
    id, name, accountId, coinSymbol, thousandSeparator, decimalSeparator,
    instatementAmount, valueLimit, valueSpent, percentage, isActive,
  ];

}