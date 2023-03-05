import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String title = "Ana Sayfa";
  final logo = 'assets/svg/logo-atcint.svg';
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: screenHeight / 5,
              width: screenWidth / 1.2,
              child: SvgPicture.asset(
                logo,
              ),
            ),
          )
        ],
      )),
    );
  }
}
