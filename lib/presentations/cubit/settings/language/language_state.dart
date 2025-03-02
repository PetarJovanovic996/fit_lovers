import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LanguageState extends Equatable {
  const LanguageState(this.locale);
  final Locale locale;
  @override
  List<Object> get props => [locale];
}

// done: Just have one state. No need for [LanguageChanged] extends [LanguageState]
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
