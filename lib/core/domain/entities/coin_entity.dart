import 'package:equatable/equatable.dart';

class CoinEntity extends Equatable {

  final String id, name, acronym, symbol;

  const CoinEntity({
    required this.id, required this.name, required this.acronym, required this.symbol,
  });

  const CoinEntity.empty() : id = "", name = "", acronym = "", symbol = "";

  const CoinEntity.defaultBrl() : id = "2jE5GBH4pT9zhSEBkwaC", name = "coins.BRL", acronym = "BRL", symbol = "R\$";

  @override
  String toString() => "CoinEntity($id, $name, $acronym, $symbol)";

  @override
  List<Object?> get props => [
    id,
    name,
    acronym,
    symbol,
  ];

}