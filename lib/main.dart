import 'package:atc_international/screens/home.dart';
import 'package:flutter/material.dart';

Map<int, Color> color = {
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

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final MaterialColor darkBlueCustom = MaterialColor(0xFF2980B9, color);
  MyApp({super.key});

  final String pageTitle = "Home";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: pageTitle,
      theme: ThemeData(
          primarySwatch: darkBlueCustom,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme:
              const AppBarTheme(backgroundColor: Colors.white, elevation: 0)),
      home: const MyHomePage(),
    );
  }
}
