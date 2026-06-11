import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:ithring_vest/session.dart';

class FieldsFormatter {

  MoneyMaskedTextController moneyController( double value, { String? leftSymbol, String? thousandSeparator, String? decimalSeparator }) {
    return MoneyMaskedTextController(
      leftSymbol: leftSymbol ?? "${Session.user.coinSymbol} ",
      initialValue: value,
      thousandSeparator: thousandSeparator ?? Session.user.thousandSeparator,
      decimalSeparator: decimalSeparator ?? Session.user.decimalSeparator,
      precision: 2,
    );
  }

}