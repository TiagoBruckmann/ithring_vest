import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class TypeAccountEntity extends Equatable {

  final String id, name;
  final bool isSelected;
  final Icon? icon;
  final double? rate;

  const TypeAccountEntity({
    required this.id, required this.name, this.isSelected = false,
    this.icon, this.rate,
  });

  const TypeAccountEntity.empty() : id = "", name = "", isSelected = false, icon = null, rate = null;

  TypeAccountEntity copyWith({
    bool? isSelected,
  }) {
    return TypeAccountEntity(
      id: id,
      name: name,
      isSelected: isSelected ?? this.isSelected,
      icon: icon,
      rate: rate,
    );
  }

  @override
  String toString() => "TypeAccountEntity($id, $name)";

  @override
  List<Object?> get props => [
    id,
    name,
    isSelected,
    icon,
    rate,
  ];

}