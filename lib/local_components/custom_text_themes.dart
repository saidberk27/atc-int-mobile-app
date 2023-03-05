import 'package:flutter/material.dart';
import 'colors.dart';

class ProjectTextStyle {
  static TextStyle lightBlueMedium(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headlineMedium!
        .copyWith(color: ProjectColor.lightBlue);
  }

  static TextStyle redMedium(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headlineMedium!
        .copyWith(color: ProjectColor.red);
  }
}
