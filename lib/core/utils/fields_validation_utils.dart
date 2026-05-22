import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:validadores/ValidarEmail.dart';
import 'package:ithring_vest/session.dart';

class FieldsValidationUtils {

  bool _hasUpperOrLowerCase( String value ) {
    final hasUpperCase = RegExp(r'[A-Z]');
    final hasLowerCase = RegExp(r'[a-z]');

    return hasUpperCase.hasMatch(value) && hasLowerCase.hasMatch(value);
  }

  bool _hasNumber( String value ) {
    final hasNumber = RegExp(r'[0-9]');
    return hasNumber.hasMatch(value);
  }

  bool _isValidPassword( String password ) {
    password = password.trim();
    final hasUpperOrLowerCase = _hasUpperOrLowerCase(password);
    final hasNumberVar = _hasNumber(password);

    final specialCharacters = RegExp(r'''[!"#$%&\'()*+,\-./:;<=>?@[\\\]^_`{|}~]''');

    if ( ( password.trim().length < 8 || password.trim().length > 20 ) || !specialCharacters.hasMatch(password) || !hasNumberVar || !hasUpperOrLowerCase ) {
      return false;
    }

    return true;
  }

  String? validateName( String value ) {
    value = value.trim();

    if ( value.isEmpty ) {
      return _translateErrorMessage("validations.mandatory.name");
    }

    final hasNumberVar = _hasNumber(value);
    final hasSpace = value.contains(" ");

    if ( !hasSpace || hasNumberVar ) {
      return _translateErrorMessage("validations.invalid.name");
    }

    return null;

  }

  String? validateEmail( String value ) {
    value = value.trim();

    if ( value.isEmpty ) {
      return _translateErrorMessage("validations.mandatory.email");
    }

    if ( !value.contains("@") ) {
      return _translateErrorMessage("validations.invalid.email");
    }

    final beforeAt = value.split("@")[0].trim();
    final afterAt = value.split("@")[1].trim();
    String afterAtBeforeDot = "";
    String afterDot = "";
    if ( afterAt.contains(".") ) {
      afterAtBeforeDot = afterAt.split(".")[0].trim();
      afterDot = afterAt.split(".")[1].trim();
    }

    if ( !EmailValidator.validate(value) || beforeAt.length < 2 || afterAtBeforeDot.length < 2 || afterDot.length < 2 ) {
      return _translateErrorMessage("validations.invalid.email");
    }

    if ( value.length > 500 ) {
      return _translateErrorMessage("validations.invalid.email_max_500_characters");
    }

    return null;

  }

  String? validateFullPhone( String value ) {
    value = Session.utils.removeAllCharacters(value).replaceAll(" ", "");

    if ( value.isEmpty ) {
      return _translateErrorMessage("validations.mandatory.phone");
    }

    if ( value.length < 8 ) {
      return _translateErrorMessage("validations.invalid.min_8_characters");
    }

    if ( value.length > 17 ) {
      return _translateErrorMessage("validations.invalid.max_17_characters");
    }

    return null;
  }

  String? validatePassword( String value, { bool isConfirm = false, String password = "" } ) {
    value = value.trim();

    if ( value.isEmpty ) {
      if ( isConfirm ) {
        return _translateErrorMessage("validations.mandatory.confirm_password");
      }
      return _translateErrorMessage("validations.mandatory.password");
    }

    if ( !_isValidPassword(value) || value.length < 8 || value.length > 20 ) {
      return _translateErrorMessage("validations.invalid.password");
    }

    if ( isConfirm && value != password.trim()) {
      return _translateErrorMessage("validations.invalid.confirm_password");
    }

    return null;
  }

  String _translateErrorMessage( String errorMessage ) {
    return FlutterI18n.translate(Session.globalContext.currentContext!, errorMessage);
  }

}