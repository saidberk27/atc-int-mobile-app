import 'package:atc_international/local_components/colors.dart';
import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:flutter/material.dart';
import 'package:atc_international/local_components/profile_picture.dart';

import '../../local_components/drawer.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});
  final String _pageTitle = "MÜŞTERİLERİM";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const ProjectDrawer(),
      appBar: AppBar(title: Text(_pageTitle)),
      body: ListView(
        children: [
          customerCard(context),
          customerCard(context),
          customerCard(context),
          customerCard(context),
          customerCard(context),
          customerCard(context),
          customerCard(context),
          const SizedBox(
            height: 60,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => print("FAB"),
        label: const Text("Yeni Müşteri"),
        icon: const Icon(Icons.add),
        shape: RoundedRectangleBorder(
            side: BorderSide(width: 3, color: ProjectColor.lightBlue),
            borderRadius: BorderRadius.circular(100)),
        backgroundColor: ProjectColor.white,
        foregroundColor: ProjectColor.lightBlue,
      ),
    );
  }

  Card customerCard(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ProfilePicture(radius: 30),
            Column(
              children: [
                Text(
                  "Said Berk",
                  style: ProjectTextStyle.redMediumStrong(context),
                ),
                Text(
                  "Aspar Enerji",
                  style: ProjectTextStyle.lightBlueSmallStrong(context),
                )
              ],
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () => print("Mesaj"),
                    icon: const Icon(Icons.chat_bubble)),
                IconButton(
                    onPressed: () => Navigator.pushNamed(context, "/customer"),
                    icon: const Icon(Icons.info_outlined))
              ],
            )
          ],
        ),
      ),
    );
  }
}
