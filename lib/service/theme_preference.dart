  import '../res/app_constants.dart';

  class ThemePreference {
    static const String _themeStatus = "THEME_STATUS";

    /// Save the theme mode preference (true = dark, false = light)
    Future<void>  setDarkTheme({required bool value}) async {
    await  AppConstants.sharedPreference!.setBool(_themeStatus, value);
    }

    /// Get the current theme mode preference

    bool getTheme() {
      return AppConstants.sharedPreference!.getBool(_themeStatus) ?? false;
    }
  }
