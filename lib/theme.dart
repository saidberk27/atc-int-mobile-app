import 'package:atc_international/local_components/colors.dart';
import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:flutter/material.dart';

ThemeData projectTheme(BuildContext context) {
  return ThemeData(
      primarySwatch: ProjectColor.customPrimarySwatch,
      scaffoldBackgroundColor: ProjectColor.white,
      appBarTheme: AppBarTheme(
        backgroundColor: ProjectColor.white,
        foregroundColor: ProjectColor.darkBlue,
        centerTitle: true,
        titleTextStyle: ProjectTextStyle.redMediumStrong(context),
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              side: const BorderSide(color: ProjectColor.darkBlue, width: 2.5),
              backgroundColor: ProjectColor.white,
              alignment: const Alignment(0, 0),
              textStyle: ProjectTextStyle.darkBlueMediumStrong(context),
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              foregroundColor: ProjectColor.darkBlue)),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ));
}
