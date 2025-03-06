import 'package:bloc/bloc.dart';
import 'package:fit_lovers/data/models/language.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences,
        super(LanguageState(Locale('en'))) {
    _getDefaultLanguage();
  }

  final SharedPreferences _sharedPreferences;

  void _getDefaultLanguage() {
    final savedLanguage = _sharedPreferences.getString('__LANGUAGE_KEY__');

    if (savedLanguage != null) {
      changeLanguage(savedLanguage);
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    final language = Language.supportedLanguages.firstWhere(
      (language) => language.code == languageCode,
    );

    emit(LanguageState(language.locale));
    _sharedPreferences.setString('__LANGUAGE_KEY__', languageCode);
  }
}
