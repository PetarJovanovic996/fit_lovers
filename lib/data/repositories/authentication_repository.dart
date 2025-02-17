import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:fit_lovers/data/repositories/models/user.dart';

class RegisterWithEmailAndPasswordFailure implements Exception {
  const RegisterWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory RegisterWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const RegisterWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );

      case 'email-already-in-use':
        return const RegisterWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );

      default:
        return const RegisterWithEmailAndPasswordFailure();
    }
  }

  final String message;
}

class LogInWithEmailAndPasswordFailure implements Exception {
  const LogInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );

      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  final String message;
}

class LogOutFailure implements Exception {}

class AuthenticationRepository {
  AuthenticationRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  late SharedPreferences _prefs;

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      _saveUserToCache(user);
      return user;
    });
  }

  Future<void> _saveUserToCache(User user) async {
    await _prefs.setString('user_id', user.id);
    await _prefs.setString('user_email', user.email ?? '');
    await _prefs.setString('user_name', user.name ?? '');
  }

  User get currentUser {
    final userId = _prefs.getString('user_id') ?? '';
    final userEmail = _prefs.getString('user_email') ?? '';
    final userName = _prefs.getString('user_name') ?? '';

    return User(
      id: userId,
      email: userEmail,
      name: userName,
    );
  }

  Future<void> register(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw RegisterWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const RegisterWithEmailAndPasswordFailure();
    }
  }

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
      await _prefs.clear();
    } catch (_) {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(
      id: uid,
      email: email,
      name: displayName,
    );
  }
}
