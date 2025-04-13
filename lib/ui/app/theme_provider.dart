import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/core/pref_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

String lightFolder = 'assets/light/';
String darkFolder = 'assets/dark/';



ThemeMode themeMode = ThemeMode.light;


class ThemeProvider extends GetxController {


  ThemeProvider() {
    themeMode =
        ThemeMode.values[PrefData.getThemeData()];
  }

  void changeTheme() async {
    if (themeMode == ThemeMode.light)
      themeMode = ThemeMode.dark;
    else
      themeMode = ThemeMode.light;
    update();
    // notifyListeners();
    await PrefData.setThemeData(themeMode.index);
    // await sharedPreferences.setInt(KeyUtil.IS_DARK_MODE, themeMode.index);
  }
}
