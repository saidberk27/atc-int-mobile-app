import 'package:flutter/material.dart';
import 'colors.dart';

class ProjectTextStyle {
  static TextStyle lightBlueBigStrong(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium!.copyWith(
          color: ProjectColor.lightBlue,
          fontSize: 36,
          fontWeight: FontWeight.bold);

  static TextStyle lightBlueBig(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: ProjectColor.lightBlue,
            fontSize: 36,
          );

  static TextStyle lightBlueMediumStrong(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium!.copyWith(
          color: ProjectColor.lightBlue,
          fontSize: 24,
          fontWeight: FontWeight.bold);

  static TextStyle lightBlueMedium(BuildContext context) => Theme.of(context)
      .textTheme
      .headlineMedium!
      .copyWith(color: ProjectColor.lightBlue, fontSize: 24);

  static TextStyle lightBlueSmallStrong(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium!.copyWith(
          color: ProjectColor.lightBlue,
          fontSize: 16,
          fontWeight: FontWeight.bold);

  static TextStyle lightBlueSmall(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: ProjectColor.lightBlue,
            fontSize: 16,
          );

  static TextStyle redBigStrong(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium!.copyWith(
          color: ProjectColor.red, fontSize: 36, fontWeight: FontWeight.bold);

  static TextStyle redBig(BuildContext context) => Theme.of(context)
      .textTheme
      .headlineMedium!
      .copyWith(color: ProjectColor.red, fontSize: 36);

  static TextStyle redMediumStrong(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium!.copyWith(
          color: ProjectColor.red, fontSize: 24, fontWeight: FontWeight.bold);

  static TextStyle redMedium(BuildContext context) => Theme.of(context)
      .textTheme
      .headlineMedium!
      .copyWith(color: ProjectColor.red, fontSize: 24);

  static TextStyle redSmall(BuildContext context) => Theme.of(context)
      .textTheme
      .headlineMedium!
      .copyWith(color: ProjectColor.red, fontSize: 16);

  static TextStyle redSmallStrong(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium!.copyWith(
          color: ProjectColor.red, fontSize: 16, fontWeight: FontWeight.bold);

  static TextStyle whiteMediumStrong(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium!.copyWith(
          color: ProjectColor.white, fontSize: 24, fontWeight: FontWeight.bold);

  static TextStyle whiteSmallStrong(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium!.copyWith(
          color: ProjectColor.white, fontSize: 16, fontWeight: FontWeight.bold);

  static TextStyle darkBlueMediumStrong(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium!.copyWith(
          color: ProjectColor.lightBlue,
          fontSize: 24,
          fontWeight: FontWeight.bold);
  static TextStyle darkBlueSmallStrong(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium!.copyWith(
          color: ProjectColor.lightBlue,
          fontSize: 16,
          fontWeight: FontWeight.bold);

  static TextStyle darkMediumStrong(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium!.copyWith(
          color: ProjectColor.darkGray,
          fontSize: 24,
          fontWeight: FontWeight.bold);

  static TextStyle darkMedium(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: ProjectColor.darkGray,
            fontSize: 24,
          );

  static TextStyle darkSmall(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: ProjectColor.darkGray,
            fontSize: 16,
          );

  static TextStyle darkSmallStrong(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium!.copyWith(
          color: ProjectColor.darkGray,
          fontSize: 16,
          fontWeight: FontWeight.bold);
}
