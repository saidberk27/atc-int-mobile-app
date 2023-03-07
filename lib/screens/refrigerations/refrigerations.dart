import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:atc_international/local_components/drawer.dart';
import 'package:atc_international/local_components/fab.dart';
import 'package:flutter/material.dart';

class Refrigerations extends StatelessWidget {
  const Refrigerations({super.key});

  @override
  Widget build(BuildContext context) {
    String imageData = "assets/images/ice-bucket.png";
    return Scaffold(
        drawer: const ProjectDrawer(),
        appBar: AppBar(
          title: const Text("KASALARIM"),
        ),
        floatingActionButton: const ProjectFAB(text: "YENİ KASA"),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              refrigerationCard(imageData, context),
              refrigerationCard(imageData, context),
              refrigerationCard(imageData, context),
              refrigerationCard(imageData, context),
              refrigerationCard(imageData, context),
              refrigerationCard(imageData, context),
              refrigerationCard(imageData, context),
              refrigerationCard(imageData, context),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ));
  }

  Padding refrigerationCard(String imageData, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, "/refrigeration"),
        child: Card(
          elevation: 4,
          child: Column(children: [
            Image.asset(imageData),
            Text(
              "KASA İSMİ",
              style: ProjectTextStyle.darkMediumStrong(context),
            ),
            Text(
              "KASA MODELİ",
              style: ProjectTextStyle.darkMedium(context),
            ),
            const Icon(
              Icons.play_arrow,
              size: 36,
            )
          ]),
        ),
      ),
    );
  }
}
