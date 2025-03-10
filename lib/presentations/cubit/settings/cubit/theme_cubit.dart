import 'package:fit_lovers/presentations/cubit/settings/cubit/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(AppTheme.light)) {
    _loadTheme();
  }

  void toggleTheme() async {
    final newTheme =
        state.appTheme == AppTheme.light ? AppTheme.dark : AppTheme.light;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', newTheme.toString());

    emit(ThemeState(newTheme));
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString('theme');

    if (themeString != null) {
      final theme = themeString == AppTheme.dark.toString()
          ? AppTheme.dark
          : AppTheme.light;
      emit(ThemeState(theme));
    } else {
      emit(const ThemeState(AppTheme.light));
    }
  }
}
