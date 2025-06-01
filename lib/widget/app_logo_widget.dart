import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../res/app_asset/icon_asset.dart';
import '../res/app_function.dart';
import '../res/app_string.dart';
import '../res/apps_text_style.dart';

/// A reusable widget that shows the app logo and name.
class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // App logo image
        Image.asset(
          AppIcons.appIconPath,
          height: 80.h,
          width: 100.w,
          fit: BoxFit.fill,
        ),
        // Vertical space between logo and text
        AppsFunction.verticalSpacing(10),
        // App name text with custom style
        Text(AppStrings.appName, style: AppsTextStyle.logoText),
      ],
    );
  }
}
