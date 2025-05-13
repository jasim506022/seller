import 'package:flutter/material.dart';

import '../theme_preference.dart';

class ThemeProvider with ChangeNotifier {

  ThemePreference themePreference = ThemePreference();

  bool _darkTheme = false;

  bool get isDarkTheme => _darkTheme;

  /// Set and save theme preference
  Future<void> setDarkTheme(bool value) async  {
    themePreference.setDarkTheme(value: value);
    _darkTheme = value;
    notifyListeners();
  }
}
