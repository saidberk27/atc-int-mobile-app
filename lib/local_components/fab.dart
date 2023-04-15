import 'package:flutter/material.dart';
import 'colors.dart';

class ProjectFAB extends StatelessWidget {
  const ProjectFAB({super.key, required this.text, required this.route});

  final String text;
  final String route;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.pushNamed(context, route);
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
