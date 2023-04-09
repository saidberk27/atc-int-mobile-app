import 'package:flutter/material.dart';
import 'colors.dart';

class ProjectFAB extends StatelessWidget {
  ProjectFAB({super.key, required this.text, required this.route});
  ProjectFAB.arguments(
      {super.key,
      required this.text,
      required this.route,
      required this.arguments});

  final String text;
  final String route;
  late List arguments;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.pushNamed(context, route, arguments: arguments);
      },
      label: Text(text),
      icon: const Icon(Icons.add),
      shape: RoundedRectangleBorder(
          side: const BorderSide(width: 3, color: ProjectColor.lightBlue),
          borderRadius: BorderRadius.circular(100)),
      backgroundColor: ProjectColor.white,
      foregroundColor: ProjectColor.lightBlue,
    );
  }
}
