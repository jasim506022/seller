

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
      // dialogTheme: _dialogTheme(),
      // cardTheme: _cardTheme(),
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










