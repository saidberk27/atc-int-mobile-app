import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:atc_international/local_components/custom_text_themes.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

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
          buildLogo(screenHeight, screenWidth),
          Row(
            children: [
              const CircleAvatar(),
              Text(
                "Hoş Geldin,",
                style: ProjectTextStyle.lightBlueMedium(context),
              ),
              Text("Ahmet", style: ProjectTextStyle.redMedium(context)),
              const Text("5 Mart 2023")
            ],
          )
        ],
      )),
    );
  }

  Align buildLogo(double screenHeight, double screenWidth) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: screenHeight / 5,
        width: screenWidth / 1.2,
        child: SvgPicture.asset(
          logo,
        ),
      ),
    );
  }
}
