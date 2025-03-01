import 'package:bloc/bloc.dart';
import 'package:fit_lovers/data/models/language.dart';
import 'package:flutter/rendering.dart';
import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageState(Locale('en')));

  // done: This logic is ok, but orElse should not be needed
  // Since you create the dropdown which provides supported languages inside the app
  // there is no need to double check if the language which was sent to [changeLanguage] is supported
  void changeLanguage(String languageCode) {
    final language = Language.supportedLanguages.firstWhere(
      (language) => language.code == languageCode,
    );

    emit(LanguageState(language.locale));
  }
}
