import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ithring_vest/core/domain/entities/type_account_entity.dart';
import 'package:ithring_vest/session.dart';

class TypeAccountModel extends TypeAccountEntity with EquatableMixin {
  TypeAccountModel({ required super.id, required super.name, super.icon, super.rate });

  factory TypeAccountModel.fromJson( Map<String, dynamic> json ) {

    double? rate;
    if ( json.containsKey("rate") ) {
      rate = json["rate"];
    }

    Icon? icon;
    if ( json.containsKey("icon") ) {
      icon = Session.utils.buildIconFromApi(json["icon"], json["icon_color"], json["icon_font_family"]);
    }

    return TypeAccountModel(
      id: json["id"],
      name: json["name"],
      icon: icon,
      rate: rate,
    );
  }

}