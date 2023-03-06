import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:flutter/material.dart';
import 'package:atc_international/local_components/profile_picture.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});
  final String _pageTitle = "MÜŞTERİLERİM";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_pageTitle)),
      body: ListView(
        children: [customerCard(context), customerCard(context)],
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
                    icon: Icon(Icons.chat_bubble)),
                IconButton(
                    onPressed: () => print("Bilgi"),
                    icon: Icon(Icons.info_outlined))
              ],
            )
          ],
        ),
      ),
    );
  }
}
