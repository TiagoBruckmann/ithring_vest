import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:validadores/ValidarEmail.dart';
import 'package:ithring_vest/session.dart';

class FieldsValidationUtils {

  bool hasUpperOrLowerCase( String value ) {
    final hasUpperCase = RegExp(r'[A-Z]');
    final hasLowerCase = RegExp(r'[a-z]');

    return hasUpperCase.hasMatch(value) && hasLowerCase.hasMatch(value);
  }

  bool hasNumber( String value ) {
    final hasNumber = RegExp(r'[0-9]');
    return hasNumber.hasMatch(value);
  }

  String? validateName( String value ) {
    value = value.trim();

    if ( value.isEmpty ) {
      return _translateErrorMessage("validations.required.field", params: {
        "field": _translateErrorMessage("fields.name.label"),
      });
    }

    final hasNumberVar = hasNumber(value);
    final hasSpace = value.contains(" ");

    if ( !hasSpace || hasNumberVar ) {
      return _translateErrorMessage("validations.invalid.name");
    }

    return null;

  }

  String? validateEmail( String value ) {
    value = value.trim();

    if ( value.isEmpty ) {
      return _translateErrorMessage("validations.required.field", params: {
        "field": _translateErrorMessage("fields.email.label"),
      });
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

  bool isPasswordValidLength( String password ) {
    return password.trim().length >= 8 && password.trim().length <= 20;
  }

  bool isValidPassword( String password ) {
    password = password.trim();
    final hasUpperOrLowerCaseVar = hasUpperOrLowerCase(password);
    final hasNumberVar = hasNumber(password);

    final specialCharacters = RegExp(r'''[!"#$%&\'()*+,\-./:;<=>?@[\\\]^_`{|}~]''');

    if ( !isPasswordValidLength(password) || !specialCharacters.hasMatch(password) || !hasNumberVar || !hasUpperOrLowerCaseVar ) {
      return false;
    }

    return true;
  }

  String? validatePassword( String password, { bool isConfirm = false, String confirmPassword = "" } ) {
    password = password.trim();
    confirmPassword = confirmPassword.trim();

    if ( password.isEmpty || ( isConfirm && confirmPassword.isEmpty ) ) {
      if ( isConfirm ) {
        return _translateErrorMessage("validations.required.field", params: {
          "field": _translateErrorMessage("fields.password.confirm_password"),
        });
      }

      return _translateErrorMessage("validations.required.field", params: {
        "field": _translateErrorMessage("fields.password.label"),
      });
    }

    if ( !isValidPassword(password) ) {
      return _translateErrorMessage("validations.invalid.password");
    }

    if ( isConfirm && password != confirmPassword.trim()) {
      return _translateErrorMessage("validations.invalid.confirm_password");
    }

    return null;
  }

  String? validateValueLimitCategory( String value ) {
    value = value.trim();

    if ( value.isEmpty ) {
      return _translateErrorMessage("validations.required.field", params: {
        "field": _translateErrorMessage("fields.value_limit_category.label"),
      });
    }

    final numberValue = Session.coinFormatter.coinToDouble(value);
    if ( numberValue <= 0 ) {
      return _translateErrorMessage("validations.invalid.value_limit_category");
    }

    return null;
  }

  String _translateErrorMessage( String errorMessage, { Map<String, String>? params }) {
    return FlutterI18n.translate(Session.globalContext.currentContext!, errorMessage, translationParams: params);
  }

}