import 'package:flutter/material.dart';

import '../constants/color_constant.dart';

extension CustomThemeMode on BuildContext{

  ThemeData getTheme({
    required Color color,
    required Color secondaryColor,
    required Brightness brightness,
    required MaterialColor primarySwatch}) {
    return ThemeData(
        appBarTheme: Theme.of(this).appBarTheme.copyWith(
            color: AppColors.transparent,
            titleTextStyle: TextStyle(
              color: color,
            ),
            iconTheme: Theme.of(this).iconTheme.copyWith(
              color: color,
            ),
            elevation: 0
        ),
        textTheme: Theme.of(this).textTheme.apply(
          bodyColor: color,
          displayColor: color,
          decorationColor: color,
        ),
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: primarySwatch,
            brightness: brightness,
            backgroundColor: secondaryColor)
            .copyWith(background: secondaryColor));
  }

  Color getBackgroundColor(){
    return Theme.of(this).colorScheme.background;
  }

  Color getSecondaryColor(){
    return Theme.of(this).colorScheme.primary;
  }
}