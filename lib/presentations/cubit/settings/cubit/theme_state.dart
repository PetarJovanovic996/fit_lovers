import 'package:equatable/equatable.dart';

enum AppTheme { light, dark }

class ThemeState extends Equatable {
  final AppTheme appTheme;

  const ThemeState(this.appTheme);

  @override
  List<Object> get props => [appTheme];
}
