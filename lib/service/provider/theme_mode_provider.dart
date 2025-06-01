import 'package:flutter/material.dart';
import 'package:seller/res/app_string.dart';

import '../../res/app_constants.dart';

/// A ChangeNotifier that manages and persists the app's theme mode
class ThemeModeProvider with ChangeNotifier {
  /// Current theme state (true = dark mode)
  bool _isDarkMode = false;

  /// Returns the current theme mode status
  bool get isDarkTheme => _isDarkMode;

  /// Sets and saves the user's theme preference
  Future<void> setDarkTheme(bool isDark) async {
    await AppConstants.sharedPreferences?.setBool(
      AppStrings.themeStatusKey,
      isDark,
    );
    _isDarkMode = isDark;
    notifyListeners();
  }
}
