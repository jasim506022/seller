import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'binding/initial_binding.dart';
import 'res/routes/app_routes.dart';
import 'res/routes/routes_name.dart';
import 'service/provider/theme_provider.dart';
import 'theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:
          const Size(450, 851), // Set the design size for responsive layout
      builder: (context, child) => MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => ThemeProvider())],
        child: Consumer<ThemeProvider>(
          builder: (_, themeProvider, _) {
            return GetMaterialApp(
              initialBinding: InitialBinding(),
              debugShowCheckedModeBanner: false,
              theme: AppTheme(isDark: themeProvider.isDarkTheme).build(),
              initialRoute: RoutesName.splashPage,
              getPages: AppRoutes.appRoutes(),
            );
          },
        ),
      ),
    );
  }
}

