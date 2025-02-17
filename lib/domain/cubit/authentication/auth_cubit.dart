import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_lovers/data/models/validation/confirm_password.dart';
import 'package:fit_lovers/data/models/validation/consent.dart';
import 'package:fit_lovers/data/models/validation/email.dart';
import 'package:fit_lovers/data/models/validation/password.dart';
import 'package:fit_lovers/domain/cubit/authentication/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  // TODO: Is this how we communicate to a 3rd party service?
  // TODO: What is [AuthRepository]?
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // TODO: I DID NOT KNOW THIS IS HOW WE HOLD STATE IN CUBITS?
  // TODO: REFACTOR. ALL of the logic for handling data.
  Email email = Email.pure();
  Password password = Password.pure();
  ConfirmPassword confirmPassword = ConfirmPassword.pure(password: '');
  Consent consent = Consent.pure();

  AuthCubit() : super(AuthInitial());

  // TODO: One cubit to rule them all? Rethink if this is the best approach, to handle all authentication traffic like this
  // Register & Login are 2 different screens, and you plan to handle both their states with 1 cubit?

  // HINT: Form input values, do not define [Authenticated] or [Unauthenticated] user states inside the app.
  Future<void> register(String email, String password, String confirmPassword,
      bool consentChecked) async {
    final emailValidation = Email.dirty(email);
    final passwordValidation = Password.dirty(password);
    final confirmPasswordValidation = ConfirmPassword.dirty(
      value: confirmPassword,
      password: password,
    );
    final consentValidation = Consent.dirty(consentChecked);

    if (emailValidation.isNotValid ||
        passwordValidation.isNotValid ||
        confirmPasswordValidation.isNotValid ||
        consentValidation.isNotValid) {
      // TODO: When creating multilingual applications, no text values can be hardcoded
      emit(AuthValidationError('Please check your input fields.'));
      return;
    }

    emit(AuthLoading());
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthAuthenticated(userCredential.user!));
    } catch (e) {
      // TODO: When creating multilingual applications, no text values can be hardcoded
      emit(AuthError("Registration failed: ${e.toString()}"));
    }
  }

  Future<void> login(String email, String password) async {
    final emailValidation = Email.dirty(email);
    final passwordValidation = Password.dirty(password);

    if (emailValidation.isNotValid || passwordValidation.isNotValid) {
      // TODO: When creating multilingual applications, no text values can be hardcoded
      emit(AuthValidationError("Invalid email or password."));
      return;
    }

    emit(AuthLoading());
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthAuthenticated(userCredential.user!));
    } catch (e) {
      // TODO: When creating multilingual applications, no text values can be hardcoded
      emit(AuthError('Invalid email or password.'));
    }
  }

  Future<void> checkAuthentication() async {
    emit(AuthLoading());
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthInitial());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      await _auth.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> updateConsent(bool consentChecked) async {
    consent = Consent.dirty(consentChecked);
    emit(AuthConsentUpdated(consentChecked));
  }
}
