import 'package:equatable/equatable.dart';
import 'package:ithring_vest/core/domain/entities/type_account_entity.dart';

class TypeAccountModel extends TypeAccountEntity with EquatableMixin {
  TypeAccountModel({required super.id, required super.name, required super.rate});

  factory TypeAccountModel.fromJson(Map<String, dynamic> json) {
    return TypeAccountModel(
      id: json["id"],
      name: json["name"],
      rate: json["rate"]
    );
  }

}