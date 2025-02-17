import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_lovers/data/models/validation/email.dart';
import 'package:fit_lovers/data/models/validation/password.dart';
import 'package:fit_lovers/data/repositories/authentication_repository.dart';
import 'package:formz/formz.dart';

part 'login_state.dart';

// done: Is this how we communicate to a 3rd party service?
// done : What is [AuthRepository]?

// done: I DID NOT KNOW THIS IS HOW WE HOLD STATE IN CUBITS?
// done: REFACTOR. ALL of the logic for handling data.

// done: One cubit to rule them all? Rethink if this is the best approach, to handle all authentication traffic like this
// Register & Login are 2 different screens, and you plan to handle both their states with 1 cubit?

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(const LoginState());

  final AuthenticationRepository _authenticationRepository;

  void enterEmail(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.password]),
      ),
    );
  }

  void enterPassword(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.email, password]),
      ),
    );
  }

  Future<void> logInWithCredentials() async {
    if (!state.isValid) return;
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
