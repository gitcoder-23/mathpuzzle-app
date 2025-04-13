import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/score_board.dart';
import 'app_constant.dart';

class PrefData{
  static SharedPreferences? sharedPreferences;

  PrefUtils() {
    // init();
    SharedPreferences.getInstance().then((value) {
      sharedPreferences = value;
    });
  }

  static Future<void> init() async {
    sharedPreferences ??= await SharedPreferences.getInstance();
    print('SharedPreference Initialized');
  }

  ///will clear all the data stored in preference
  void clearPreferencesData() async {
    sharedPreferences!.clear();
  }


  static int getThemeData() {
    return sharedPreferences!.getInt(KeyUtil.IS_DARK_MODE) ?? 1;
  }

  static Future<void> setThemeData(int value) {
    return sharedPreferences!.setInt(KeyUtil.IS_DARK_MODE, value);
  }


  static String getScoreboardPref(String gameCategoryType) {
    return sharedPreferences!.getString(gameCategoryType) ?? "{}";
  }

  static Future<void> setScoreboardPref(String gameCategoryType, ScoreBoard scoreboard) {
    return sharedPreferences!.setString(gameCategoryType, json.encode(scoreboard.toJson()));
  }

  static int getOverallScorePref() {
    return sharedPreferences!.getInt("overall_score") ?? 0;
  }

  static Future<void> setOverallScorePref(int _overallScore) {
    return sharedPreferences!.setInt("overall_score", _overallScore);
  }
  static Future<void> setHintScorePref(int newScore) {
    return sharedPreferences!.setInt("overall_score", newScore);
  }
}