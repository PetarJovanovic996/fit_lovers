import 'package:formz/formz.dart';

enum ConsentValidationError { notChecked }

class Consent extends FormzInput<bool, ConsentValidationError> {
  const Consent.pure() : super.pure(false);
  // ignore: use_super_parameters
  const Consent.dirty([bool value = false]) : super.dirty(value);

  @override
  ConsentValidationError? validator(bool value) {
    if (!value) {
      return ConsentValidationError.notChecked;
    }
    return null;
  }
}
