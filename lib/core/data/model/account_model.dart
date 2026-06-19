import 'package:equatable/equatable.dart';
import 'package:ithring_vest/core/domain/entities/account_entity.dart';
import 'package:ithring_vest/session.dart';

class AccountModel extends AccountEntity with EquatableMixin {
  AccountModel({ required super.id, required super.name, required super.typeAccount, required super.father, required super.isDefault, required super.isBlocked, required super.amount, required super.oldBalance, required super.qtdStock, required super.icon, super.coinSymbol, super.thousandSeparator, super.decimalSeparator, super.children });

  factory AccountModel.fromJson( Map<String, dynamic> json ) {

    final coinSymbol = json["coin_symbol"];
    final thousandSeparator = json["thousand_separator"];
    final decimalSeparator = json["decimal_separator"];

    return AccountModel(
      id: json["id"],
      name: json["name"],
      father: json["father"],
      typeAccount: json["type_account"],
      isDefault: json["is_default"],
      isBlocked: json["is_blocked"],
      amount: Session.fieldsFormatter.moneyController(json["amount"], leftSymbol: coinSymbol, thousandSeparator: thousandSeparator, decimalSeparator: decimalSeparator).text,
      oldBalance: Session.fieldsFormatter.moneyController(json["old_balance"], leftSymbol: coinSymbol, thousandSeparator: thousandSeparator, decimalSeparator: decimalSeparator).text,
      qtdStock: json["qtd_stock"],
      icon: Session.utils.buildIconFromApi(json["icon"], json["icon_color"], json["icon_font_family"]),
    );
  }

  factory AccountModel.fromEntity( AccountEntity entity ) {
    String id = entity.id;
    if ( id.trim().isEmpty ) {
      id = Session.utils.getRandomString(20);
    }

    return AccountModel(
      id: id,
      name: entity.name,
      father: entity.father,
      typeAccount: entity.typeAccount,
      isDefault: entity.isDefault,
      isBlocked: entity.isBlocked,
      amount: entity.amount,
      oldBalance: entity.oldBalance,
      qtdStock: entity.qtdStock,
      icon: entity.icon,
      coinSymbol: entity.coinSymbol,
      thousandSeparator: entity.thousandSeparator,
      decimalSeparator: entity.decimalSeparator,
    );
  }
  
}