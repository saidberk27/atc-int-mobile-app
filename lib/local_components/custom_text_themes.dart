import 'package:flutter/material.dart';
import 'colors.dart';

class ProjectTextStyle {
  static TextStyle lightBlueMedium(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headlineMedium!
        .copyWith(color: ProjectColor.lightBlue, fontSize: 24);
  }

  static TextStyle redMedium(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headlineMedium!
        .copyWith(color: ProjectColor.red, fontSize: 24);
  }

  static TextStyle whiteMediumStrong(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium!.copyWith(
        color: ProjectColor.white, fontSize: 24, fontWeight: FontWeight.bold);
  }

  static TextStyle lightBlueMediumStrong(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium!.copyWith(
        color: ProjectColor.lightBlue,
        fontSize: 24,
        fontWeight: FontWeight.bold);
  }

  static TextStyle darkBlueMediumStrong(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium!.copyWith(
        color: ProjectColor.lightBlue,
        fontSize: 24,
        fontWeight: FontWeight.bold);
  }

  static TextStyle darkSmall(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium!.copyWith(
          color: ProjectColor.darkGray,
          fontSize: 16,
        );
  }
}
