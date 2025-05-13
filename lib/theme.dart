

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../res/apps_color.dart';

class AppTheme {
  final bool isDark;

  AppTheme({required this.isDark});

  ThemeData build() {
    return ThemeData(
      scaffoldBackgroundColor: _color(AppColors.backgroundDark, AppColors.backgroundLight),
      canvasColor: _color(AppColors.cardDark, AppColors.searchLightColor),
      cardColor: _color(AppColors.cardDark, AppColors.white),
      primaryColor: _color(AppColors.white, AppColors.black),
      unselectedWidgetColor: _color(AppColors.indicatorDark, AppColors.indicatorLight),
      hintColor: _color(AppColors.hintDark, AppColors.hintLight),

      dialogTheme: _dialogTheme(),
      cardTheme: _cardTheme(),
      iconTheme: _iconTheme(),
      appBarTheme: _appBarTheme(),
      dividerTheme: _dividerTheme(),
      elevatedButtonTheme: _buttonTheme(),
      progressIndicatorTheme: _progressIndicatorTheme(),
    );
  }

  T _color<T>(T dark, T light) => isDark ? dark : light;

  DialogTheme _dialogTheme() => DialogTheme(
    backgroundColor: _color(AppColors.cardDark, AppColors.white),
    titleTextStyle: GoogleFonts.poppins(
      color: _color(AppColors.white, AppColors.black),
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
    ),
    contentTextStyle: GoogleFonts.poppins(
      color: _color(
        AppColors.white.withOpacity(.7),
        AppColors.black.withOpacity(.7),
      ),
      fontSize: 15.sp,
      fontWeight: FontWeight.normal,
    ),
  );

  CardTheme _cardTheme() => CardTheme(
    elevation: 2,
    color: _color(AppColors.cardDark, AppColors.white),
  );

  IconThemeData _iconTheme() => IconThemeData(
    color: _color(AppColors.white, AppColors.black),
    size: 25.h,
  );

  AppBarTheme _appBarTheme() => AppBarTheme(
    iconTheme: IconThemeData(
      color: _color(AppColors.white, AppColors.black),
    ),
    backgroundColor: _color(AppColors.backgroundDark, AppColors.backgroundLight),
    titleTextStyle: GoogleFonts.roboto(
      color: _color(AppColors.white, AppColors.black),
      fontSize: 22.sp,
      fontWeight: FontWeight.bold,
    ),
    centerTitle: true,
  );

  DividerThemeData _dividerTheme() => DividerThemeData(
    color: _color(AppColors.hintDark, AppColors.hintLight),
    thickness: 2,
  );

  ElevatedButtonThemeData _buttonTheme() => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.zero,
      backgroundColor: AppColors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
    ),
  );

  ProgressIndicatorThemeData _progressIndicatorTheme() =>
      const ProgressIndicatorThemeData(
        color: AppColors.white,
        linearTrackColor: AppColors.red,
        circularTrackColor: AppColors.red,
        refreshBackgroundColor: AppColors.red,
      );
}











/*
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../res/apps_color.dart';
import '../service/provider/theme_provider.dart';

ThemeData buildAppTheme(ThemeProvider themeProvider) {
  final isDark = themeProvider.isDarkTheme;

  return ThemeData(
    dialogTheme: _dialogTheme(isDark),
    cardTheme: _cardTheme(isDark),
    iconTheme: _iconTheme(isDark),
    appBarTheme: _appBarTheme(isDark),
    dividerTheme: _dividerTheme(isDark),
    elevatedButtonTheme: _buttonTheme(),
    progressIndicatorTheme: _progressIndicatorTheme(),
    scaffoldBackgroundColor:
        isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
    cardColor: isDark ? AppColors.cardDark : AppColors.white,
    canvasColor: isDark ? AppColors.cardDark : AppColors.searchLightColor,
    unselectedWidgetColor:
        isDark ? AppColors.indicatorDark : AppColors.indicatorLight,
    hintColor: isDark ? AppColors.hintDark : AppColors.hintLight,
    primaryColor: isDark ? AppColors.white : AppColors.black,
  );
}

// Extracted Dialog Theme
DialogTheme _dialogTheme(bool isDark) => DialogTheme(
      backgroundColor: isDark ? AppColors.cardDark : AppColors.white,
      titleTextStyle: GoogleFonts.poppins(
        color: isDark ? AppColors.white : AppColors.black,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: GoogleFonts.poppins(
        color: isDark
            ? AppColors.white.withOpacity(.7)
            : AppColors.black.withOpacity(.7),
        fontSize: 15.sp,
        fontWeight: FontWeight.normal,
      ),
    );

// Extracted Card Theme
CardTheme _cardTheme(bool isDark) => CardTheme(
      elevation: 2,
      color: isDark ? AppColors.cardDark : AppColors.white,
    );

// Extracted Icon Theme
IconThemeData _iconTheme(bool isDark) => IconThemeData(
      color: isDark ? AppColors.white : AppColors.black,
      size: 25.h,
    );

// Extracted AppBar Theme
AppBarTheme _appBarTheme(bool isDark) => AppBarTheme(
      iconTheme: IconThemeData(
        color: isDark ? AppColors.white : AppColors.black,
      ),
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      titleTextStyle: GoogleFonts.roboto(
        color: isDark ? AppColors.white : AppColors.black,
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
      ),
      centerTitle: true,
    );

// Extracted Divider Theme
DividerThemeData _dividerTheme(bool isDark) => DividerThemeData(
      color: isDark ? AppColors.hintDark : AppColors.hintLight,
      thickness: 2,
    );

// Extracted Button Theme
ElevatedButtonThemeData _buttonTheme() => ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: AppColors.green,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      ),
    );

// Extracted Progress Indicator Theme
ProgressIndicatorThemeData _progressIndicatorTheme() =>
    const ProgressIndicatorThemeData(
      color: AppColors.white,
      linearTrackColor: AppColors.red,
      circularTrackColor: AppColors.red,
      refreshBackgroundColor: AppColors.red,
    );
*/