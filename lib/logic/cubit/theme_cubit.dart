import 'package:bloc_architecture_app/core/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(themeMode: ThemeMode.light)) {
    refreshAppTheme();
  }

  void refreshAppTheme() {
    Brightness currentBrightness = AppTheme.currentSystemBrightness;
    currentBrightness == Brightness.light
        ? _setTheme(ThemeMode.light)
        : _setTheme(ThemeMode.dark);
  }

  _setTheme(ThemeMode themeMode) {
    AppTheme.setStatusAndNavigationBarColors(themeMode);
    emit(ThemeState(themeMode: themeMode));
  }
}
