import 'package:formz/formz.dart';

enum EmailValidationError { invalid, empty }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  // ignore: use_super_parameters
  const Email.dirty([String value = '']) : super.dirty(value);

  static final RegExp _emailRegex = RegExp(
      r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty) {
      return EmailValidationError.empty;
    }
    if (!_emailRegex.hasMatch(value)) {
      return EmailValidationError.invalid;
    }
    return null;
  }
}
