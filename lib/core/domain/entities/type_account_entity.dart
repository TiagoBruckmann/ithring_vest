import 'package:equatable/equatable.dart';

class TypeAccountEntity extends Equatable {

  final String id, name;
  final double rate;

  const TypeAccountEntity({
    required this.id, required this.name,
    required this.rate,
  });

  const TypeAccountEntity.empty() : id = "", name = "", rate = 0;

  @override
  String toString() => "TypeAccountEntity($id, $name)";

  @override
  List<Object?> get props => [
    id,
    name,
    rate,
  ];

}