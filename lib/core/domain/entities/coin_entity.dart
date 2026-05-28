import 'package:equatable/equatable.dart';

class CoinEntity extends Equatable {

  final String name, acronym, symbol, thousandSeparator, decimalSeparator;

  const CoinEntity({
    required this.name, required this.acronym,
    required this.symbol, required this.thousandSeparator,
    required this.decimalSeparator,
  });

  const CoinEntity.empty() : name = "", acronym = "", symbol = "", thousandSeparator = "", decimalSeparator = "";

  const CoinEntity.defaultBrl() : name = "coins.BRL", acronym = "BRL", symbol = "R\$", thousandSeparator = ".", decimalSeparator = ",";

  @override
  String toString() => "CoinEntity($name, $acronym, $symbol)";

  @override
  List<Object?> get props => [
    name,
    acronym,
    symbol,
    thousandSeparator,
    decimalSeparator,
  ];

}