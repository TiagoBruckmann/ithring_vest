import 'package:equatable/equatable.dart';
import 'package:ithring_vest/core/domain/entities/coin_entity.dart';

class CoinModel extends CoinEntity with EquatableMixin {
  CoinModel({ required super.name, required super.acronym, required super.symbol, required super.thousandSeparator, required super.decimalSeparator });

  factory CoinModel.fromJson( Map<String, dynamic> json ) {
    return CoinModel(
      acronym: json["acronym"],
      name: json["name"],
      symbol: json["symbol"],
      thousandSeparator: json["thousand_separator"],
      decimalSeparator: json["decimal_separator"],
    );
  }

}