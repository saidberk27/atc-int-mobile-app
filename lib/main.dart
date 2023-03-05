import 'package:atc_international/screens/home.dart';
import 'package:flutter/material.dart';
import 'local_components/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String pageTitle = "Home";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: pageTitle,
      theme: ThemeData(
        primarySwatch: ProjectColor.customPrimarySwatch,
        scaffoldBackgroundColor: ProjectColor.white,
        appBarTheme:
            AppBarTheme(backgroundColor: ProjectColor.white, elevation: 0),
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
