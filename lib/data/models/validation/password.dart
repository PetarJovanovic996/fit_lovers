import 'package:formz/formz.dart';

enum PasswordValidationError { tooShort, missingNumbers }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String value) {
    if (value.length < 6) {
      return PasswordValidationError.tooShort;
    }

    final hasNumber = RegExp(r'\d').hasMatch(value);
    if (!hasNumber) {
      return PasswordValidationError.missingNumbers;
    }

    return null;
  }
}
