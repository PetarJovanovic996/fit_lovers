part of 'register_cubit.dart';

final class RegisterState extends Equatable {
  const RegisterState(
      {this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.confirmedPassword = const ConfirmedPassword.pure(),
      this.status = FormzSubmissionStatus.initial,
      this.isValid = false,
      this.errorMessage,
      this.consent = const Consent.pure()});

  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;
  final Consent consent;

  RegisterState copyWith({
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
    Consent? consent,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
      consent: consent ?? this.consent,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        confirmedPassword,
        status,
        isValid,
        errorMessage,
        consent,
      ];
}
