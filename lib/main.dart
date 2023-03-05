import 'package:atc_international/screens/home_screen/home.dart';
import 'package:atc_international/screens/home_screen/notifications.dart';
import 'package:flutter/material.dart';
import 'local_components/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: ProjectColor.customPrimarySwatch,
        scaffoldBackgroundColor: ProjectColor.white,
        appBarTheme: AppBarTheme(
          backgroundColor: ProjectColor.white,
          foregroundColor: ProjectColor.darkBlue,
          elevation: 0,
        ),
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/notifications': (context) => const NotificationsPage(),
      },
    );
  }
}
