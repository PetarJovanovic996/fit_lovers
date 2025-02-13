// Definisanje Auth State
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthAuthenticated extends AuthState {
  final User user;
  AuthAuthenticated(this.user);

  @override
  List<Object> get props => [user];
}

class AuthError extends AuthState {
  final String errorMessage;
  AuthError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class AuthValidationError extends AuthState {
  final String errorMessage;
  AuthValidationError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class AuthConsentUpdated extends AuthState {
  final bool consent;

  AuthConsentUpdated(this.consent);
  @override
  List<Object> get props => [consent];
}
