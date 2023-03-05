import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final String title = "Ana Sayfa";
  final logo = 'assets/svg/logo-atcint.svg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(
          child: Column(
        children: [
          SvgPicture.asset(
            logo,
          )
        ],
      )),
    );
  }
}
