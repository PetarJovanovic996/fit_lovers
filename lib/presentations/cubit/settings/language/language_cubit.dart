import 'package:bloc/bloc.dart';
import 'package:fit_lovers/data/models/language.dart';
import 'package:flutter/rendering.dart';
import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageChanged(Locale('en')));

  // TODO: This logic is ok, but orElse should not be needed
  // Since you create the dropdown which provides supported languages inside the app
  // there is no need to double check if the language which was sent to [changeLanguage] is supported
  void changeLanguage(String languageCode) {
    final language = Language.supportedLanguages.firstWhere(
      (language) => language.code == languageCode,
      orElse: () => Language.supportedLanguages.first,
    );

    emit(LanguageChanged(language.locale));
  }

  // TODO: This is duplicating the same thing, this is not needed here
  // For fetching available languages fetch them directly from [Language.availableLanguages]
  // the logic is already there
  List<Map<String, String>> get availableLanguages {
    return Language.availableLanguages;
  }
}
