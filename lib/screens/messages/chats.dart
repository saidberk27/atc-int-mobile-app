import 'package:atc_international/local_components/fab.dart';
import 'package:flutter/material.dart';

import '../../local_components/custom_text_themes.dart';
import '../../local_components/profile_picture.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var pageTitle = 'MESAJLARIM';
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: ListView(
        children: [
          chatCard(context, chatName: "Said Berk", isOnline: true),
          chatCard(context, chatName: "Said Berk", isOnline: true),
          chatCard(context, chatName: "Said Berk", isOnline: true)
        ],
      ),
      floatingActionButton:
          ProjectFAB(text: "YENİ MESAJ", route: "/addNewChat"),
    );
  }

  InkWell chatCard(
    BuildContext context, {
    required String chatName,
    required bool isOnline,
  }) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed("/customChat"),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProfilePicture(radius: 30),
              Column(
                children: [
                  Text(
                    chatName, //TODO take care of possible long names
                    style: ProjectTextStyle.redMediumStrong(context),
                  ),
                  Row(
                    children: [
                      Text(
                        isOnline ? "Çevrim içi" : "Çevrim Dışı",
                        style: ProjectTextStyle.lightBlueSmallStrong(context),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 80,
                      ),
                      CircleAvatar(
                        backgroundColor: isOnline ? Colors.green : Colors.red,
                        maxRadius: MediaQuery.of(context).size.width / 60,
                      ),
                    ],
                  )
                ],
              ),
              Icon(Icons.arrow_right),
            ],
          ),
        ),
      ),
    );
  }
}
