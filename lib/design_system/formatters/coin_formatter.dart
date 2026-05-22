import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:ithring_vest/core/domain/enums/currency_enum.dart';
import 'package:ithring_vest/session.dart';

class CoinFormatter {

  String currencyFormat( String coin ) {
    return CurrencyEnum.values.firstWhere((currency) => currency.coin.toUpperCase() == coin).format;
  }

  String doubleToCoin( double value ) {
    return MoneyMaskedTextController(
      leftSymbol: "${Session.user.currencyFormat} ",
      initialValue: value,
      thousandSeparator: ".",
      decimalSeparator: ",",
      precision: 2,
    ).text;
  }

  double coinToDouble( String value ) {
    String cleanValue;
    if ( value.contains(",") ) {
      cleanValue = value.replaceAll(RegExp(r'[^\d,]'), '').replaceAll(",", ".");
    } else {
      cleanValue = value.replaceAll(RegExp(r'[^\d.]'), '');
    }
    return double.tryParse(cleanValue) ?? 0.0;
  }

}