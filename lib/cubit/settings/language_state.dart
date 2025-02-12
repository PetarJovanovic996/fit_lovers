import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
