import 'package:flutter/material.dart';
import 'colors.dart';

class ProjectFAB extends StatelessWidget {
  const ProjectFAB({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => print("FAB"),
      label: Text(text),
      icon: const Icon(Icons.add),
      shape: RoundedRectangleBorder(
          side: BorderSide(width: 3, color: ProjectColor.lightBlue),
          borderRadius: BorderRadius.circular(100)),
      backgroundColor: ProjectColor.white,
      foregroundColor: ProjectColor.lightBlue,
    );
  }
}
