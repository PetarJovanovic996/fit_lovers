import 'package:formz/formz.dart';

enum ConsentValidationError { notChecked }

class Consent extends FormzInput<bool, ConsentValidationError> {
  const Consent.pure([bool value = false]) : super.pure(false);
  const Consent.dirty([super.value = false]) : super.dirty();

  @override
  ConsentValidationError? validator(bool value) {
    if (!value) {
      return ConsentValidationError.notChecked;
    }
    return null;
  }
}
