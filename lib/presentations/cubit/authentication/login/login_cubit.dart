import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_lovers/data/models/validation/email.dart';
import 'package:fit_lovers/data/models/validation/password.dart';
import 'package:fit_lovers/data/repositories/authentication_repository.dart';
import 'package:formz/formz.dart';

part 'login_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit(this._authenticationRepository) : super(const LogInState());

  final AuthenticationRepository _authenticationRepository;

  void enteredEmail(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate(
          [email, state.password],
        ),
      ),
    );
  }

  void enteredPassword(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.email, password]),
      ),
    );
  }

  Future<void> logInWithCredentials() async {
    if (!state.isValid) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
        ),
      );
      return;
    }
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authenticationRepository.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzSubmissionStatus.failure,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
