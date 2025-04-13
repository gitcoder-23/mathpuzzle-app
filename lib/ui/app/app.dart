import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/core/app_theme.dart';
import 'package:mathspuzzle/core/app_routes.dart';
import 'package:mathspuzzle/ui/app/theme_provider.dart';

class MyApp extends StatelessWidget {
  final String fontFamily = "Montserrat";

  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GetBuilder<ThemeProvider>(
      init: ThemeProvider(),
      builder: (controller) {
      return GetMaterialApp(
        title: 'MathsPuzzle',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeMode,
        initialRoute: KeyUtil.dashboard,
        routes: appRoutes,
      );
    },);


    // return Consumer<ThemeProvider>(
    //     builder: (context, ThemeProvider provider, child) {
    //   return GetMaterialApp(
    //     title: 'MathIQ',
    //     debugShowCheckedModeBanner: false,
    //     theme: AppTheme.theme,
    //     darkTheme: AppTheme.darkTheme,
    //     themeMode: themeMode,
    //     initialRoute: KeyUtil.splash,
    //     routes: appRoutes,
    //   );
    // });
  }




}

