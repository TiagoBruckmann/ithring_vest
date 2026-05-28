import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:ithring_vest/session.dart';

class CoinFormatter {

  String doubleToCoin( double value ) {
    return MoneyMaskedTextController(
      leftSymbol: "${Session.user.coinSymbol} ",
      initialValue: value,
      thousandSeparator: Session.user.thousandSeparator,
      decimalSeparator: Session.user.decimalSeparator,
      rightSymbol: "%",
      precision: 2,
    ).text;
  }

  String doubleToPercentage( double value ) {
    return MoneyMaskedTextController(
      initialValue: value,
      thousandSeparator: ".",
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