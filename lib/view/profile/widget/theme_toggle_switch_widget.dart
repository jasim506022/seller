  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';

  import '../../../res/app_string.dart';
  import '../../../res/apps_color.dart';
  import '../../../res/apps_text_style.dart';
  import '../../../service/provider/theme_mode_provider.dart';

  /// A widget that displays a switch to toggle between Light Mode and Dark Mode.
  ///
  /// It uses [ThemeModeProvider] from the Provider package to manage and update
  /// the app's theme state. The switch updates the UI and theme icon accordingly.
  class ThemeToggleSwitchWidget extends StatelessWidget {
    const ThemeToggleSwitchWidget({
      super.key,
    });

    @override
    Widget build(BuildContext context) {
      return Consumer<ThemeModeProvider>(
        builder: (context, themeProvider, child) {
          final bool isDarkMode = themeProvider.isDarkTheme;
          return SwitchListTile(
            // Leading icon that changes between light and dark mode icons.
          secondary: Icon(
              isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: Theme.of(context).primaryColor,
            ),

            // Title text showing the current theme mode
            title: Text(
              isDarkMode ? AppStrings.darkLabel : AppStrings.lightLabel,
              style: AppsTextStyle.largeBold,
            ),

            // Controls the switch's active color and toggling behavior.

            activeColor: AppColors.white,
            onChanged: (bool value) => themeProvider.setDarkTheme (value),
            value: themeProvider.isDarkTheme,
          );
        },
      );
    }
  }

  /*
  1. Please try to understand consumer in prover
   */

