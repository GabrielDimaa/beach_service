import 'package:beach_service/app/shared/extensions/string_extension.dart';
import 'package:beach_service/app/shared/extensions/email_extension.dart';

abstract class Validator {
  String message();
  bool isError(String value);
}

class InputValidator {
  final Validator validator;
  final bool isRequired;

  InputValidator(this.validator, {this.isRequired = true});

  String validate(String text) {
    if (isRequired) {
      if (text.isNullOrEmpty()) return "Campo obrigatório!";
      if (validator.isError(text)) return validator.message();
    } else {
      if (text.notIsNullOrEmpty()) {
        if (validator.isError(text)) return validator.message();
      }
    }

    return null;
  }
}

class DefaultValidator extends Validator {
  final String campo;

  DefaultValidator(this.campo);

  @override
  String message() => '$campo inválido!';

  @override
  bool isError(String value) {
    if (value.notIsNullOrEmpty()) {
      return false;
    } else {
      return true;
    }
  }
}

class EmailValidator extends Validator {
  @override
  String message() => 'Email inválido!';

  @override
  bool isError(String email) {
    if (email.notIsNullOrEmpty() && email.isEmailValid()) {
      return false;
    } else {
      return true;
    }
  }
}

class CepValidator extends Validator {
  @override
  String message() => "CEP inválido!";

  @override
  bool isError(String value) {
    String text = value.extrairNum();

    if (text.notIsNullOrEmpty() && text.length == 8) {
      return false;
    } else {
      return true;
    }
  }
}

class PasswordValidator extends Validator {
  @override
  String message() => "Senha inválida, mínimo 8 caracteres!";

  @override
  bool isError(String value) {
    if (value.notIsNullOrEmpty() && value.length > 8) {
      return false;
    } else {
      return true;
    }
  }
}

class TelefoneValidator extends Validator {
  @override
  String message() => "Telefone inválido!";

  @override
  bool isError(String value) {
    String text = value.extrairNum();

    if (text.notIsNullOrEmpty() && text.length >= 10) {
      return false;
    } else {
      return true;
    }
  }
}
