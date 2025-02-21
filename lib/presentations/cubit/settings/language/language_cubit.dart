import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());

  void changeLanguage(Locale locale) {
    // done: We emit loading when something asynchronous happens, emitting a new state is not async operation?

    // done: Why do we have try catch here, logic of emitting new state cannot fail. Refactor
    emit(LanguageChanged(locale));
  }
}
