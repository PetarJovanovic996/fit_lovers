import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());

  Future<void> changeLanguage(Locale locale) async {
    // TODO: We emit loading when something asynchronous happens, emitting a new state is not async operation?

    emit(LanguageLoading());
    // TODO: Why do we have try catch here, logic of emitting new state cannot fail. Refactor
    try {
      emit(LanguageChanged(locale));
    } catch (e) {
      emit(LanguageEroor(e.toString()));
    }
  }
}
