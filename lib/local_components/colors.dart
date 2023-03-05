import 'package:flutter/material.dart';

class ProjectColor {
  static Map<int, Color> color = {
    50: const Color.fromRGBO(41, 128, 185, .1),
    100: const Color.fromRGBO(41, 128, 185, .2),
    200: const Color.fromRGBO(41, 128, 185, .3),
    300: const Color.fromRGBO(41, 128, 185, .4),
    400: const Color.fromRGBO(41, 128, 185, .5),
    500: const Color.fromRGBO(41, 128, 185, .6),
    600: const Color.fromRGBO(41, 128, 185, .7),
    700: const Color.fromRGBO(41, 128, 185, .8),
    800: const Color.fromARGB(228, 58, 99, 126),
    900: const Color.fromRGBO(41, 128, 185, 1),
  };

  static Color darkGray = const Color(0XFF2C3E50);
  static Color red = const Color(0XFFE74C3C);
  static Color lightGray = const Color(0XFFECF0F1);
  static Color lightBlue = const Color(0XFF3498DB);
  static Color darkBlue = const Color(0XFF2980B9);
  static Color white = const Color(0XFFFFFFFF);

  static MaterialColor get customPrimarySwatch =>
      MaterialColor(0xFF2980B9, color);
}
