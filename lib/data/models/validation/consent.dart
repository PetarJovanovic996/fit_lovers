import 'package:formz/formz.dart';

enum ConsentValidationError { notChecked }

class Consent extends FormzInput<bool, ConsentValidationError> {
  const Consent.pure() : super.pure(false);
  const Consent.dirty([bool value = false]) : super.dirty(value);

  @override
  ConsentValidationError? validator(bool value) {
    if (!value) {
      return ConsentValidationError.notChecked;
    }
    return null;
  }
}
