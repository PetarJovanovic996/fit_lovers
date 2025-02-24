import 'package:bloc/bloc.dart';
import 'package:fit_lovers/data/models/language.dart';
import 'package:flutter/rendering.dart';
import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageChanged(Locale('en')));

  void changeLanguage(String languageCode) {
    final language = Language.supportedLanguages.firstWhere(
      (language) => language.code == languageCode,
      orElse: () => Language.supportedLanguages.first,
    );

    emit(LanguageChanged(language.locale));
  }

  List<Map<String, String>> get availableLanguages {
    return Language.availableLanguages;
  }
}
