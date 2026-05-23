import 'package:equatable/equatable.dart';
import 'package:ithring_vest/core/domain/entities/coin_entity.dart';

class CoinModel extends CoinEntity with EquatableMixin {
  CoinModel({ required super.id, required super.name, required super.acronym });

  factory CoinModel.fromJson( Map<String, dynamic> json ) {
    return CoinModel(
      id: json["id"],
      acronym: json["acronym"],
      name: json["name"],
    );
  }

}