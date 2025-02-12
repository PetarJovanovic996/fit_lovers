import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());

  Future<void> changeLanguage(Locale locale) async {
    emit(LanguageLoading());
    try {
      emit(LanguageChanged(locale));
    } catch (e) {
      emit(LanguageEroor(e.toString()));
    }
  }
}
