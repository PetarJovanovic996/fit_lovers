import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// done: Think if this is the best approach for creating LanguageState,
// should a LanguageState have more than 1 type of state?
// done: Refactor

// reduced to 2 states

abstract class LanguageState extends Equatable {
  const LanguageState();
}

class LanguageInitial extends LanguageState {
  @override
  List<Object?> get props => [];
}

class LanguageChanged extends LanguageState {
  final Locale locale;

  const LanguageChanged(this.locale);

  @override
  List<Object> get props => [locale];
}
