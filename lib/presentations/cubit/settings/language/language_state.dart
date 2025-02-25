import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LanguageState extends Equatable {
  const LanguageState();
}

// TODO: Just have one state. No need for [LanguageChanged] extends [LanguageState]
// just use:

// class LanguageState extends Equatable {
//   final Locale locale;
//
//   const LanguageChanged(this.locale);
//
//   @override
//   List<Object> get props => [locale];
// }

// and then use LanguageState everywhere throughout the app.

class LanguageChanged extends LanguageState {
  final Locale locale;

  const LanguageChanged(this.locale);

  @override
  List<Object> get props => [locale];
}
