import 'package:equatable/equatable.dart';

class CoinEntity extends Equatable {

  final String id, name, acronym;

  const CoinEntity({
    required this.id, required this.name, required this.acronym,
  });

  const CoinEntity.empty() : id = "", name = "", acronym = "";

  @override
  String toString() => "CoinEntity($id, $name, $acronym)";

  @override
  List<Object?> get props => [
    id,
    name,
    acronym,
  ];

}