import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// TODO: Think if this is the best approach for creating LanguageState,
// should a LanguageState have more than 1 type of state?
// TODO: Refactor
abstract class LanguageState extends Equatable {
  const LanguageState();
}

class LanguageInitial extends LanguageState {
  @override
  List<Object?> get props => [];
}

class LanguageLoading extends LanguageState {
  @override
  List<Object?> get props => [];
}

class LanguageChanged extends LanguageState {
  final Locale locale;

  const LanguageChanged(this.locale);

  @override
  List<Object> get props => [locale];
}

class LanguageEroor extends LanguageState {
  const LanguageEroor(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
