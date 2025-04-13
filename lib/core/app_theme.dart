import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mathspuzzle/core/app_constant.dart';

class AppTheme {
  static ThemeData get  theme {
    ThemeData base = ThemeData.light();

    return base.copyWith(
      splashColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      cardColor: Colors.white,
      textTheme: base.textTheme.copyWith(
        labelSmall: base.textTheme.labelSmall!.copyWith(
          color: Color(0xff757575),
        ),
        // add bodytext1
        // subtitle1: base.textTheme.titleMedium!.copyWith(color:  "#310062".toColor()),
        // subtitle2: base.textTheme.titleSmall!.copyWith(color:  "#310062".toColor()),
        // bodyText1: base.textTheme.bodySmall!.copyWith(color:  "#310062".toColor()),
        // subtitle1: base.textTheme.titleMedium!.copyWith(color: "#310062".toColor())
      ),
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
    );
  }

  static ThemeData get darkTheme {
    ThemeData base = ThemeData.dark();

    return base.copyWith(
      splashColor: Colors.black,
      scaffoldBackgroundColor: Colors.black,
      cardColor: Colors.black,
      textTheme: base.textTheme.copyWith(
        labelSmall: base.textTheme.labelSmall!.copyWith(
          color: Color(0xff616161),
        ),
      ),
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
    );
  }
}
