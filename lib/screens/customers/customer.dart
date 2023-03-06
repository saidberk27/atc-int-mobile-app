import 'package:atc_international/local_components/colors.dart';
import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:flutter/material.dart';

import '../../local_components/drawer.dart';
import '../../local_components/profile_picture.dart';

class CustomerPage extends StatelessWidget {
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          userTitle(context),
          Divider(
            thickness: 2,
            color: ProjectColor.red,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Column(
                children: [
                  ChatBubbleRow(context),
                  NormalRow(context, "Çalıştığı Şirket: ", "Aspar Enerji"),
                  NormalRow(context, "Unvan: ", "Yazılım Geliştirici"),
                  NormalRow(context, "E-Posta: ", "csaidberk@gmail.com"),
                  NormalRow(context, "Telefon: ", "+90 505 122 23 46")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  SizedBox ChatBubbleRow(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Text(
            "İsim Soyisim: ",
            style: ProjectTextStyle.redSmallStrong(context),
          ),
          Text(
            "Said Berk",
            style: ProjectTextStyle.lightBlueSmallStrong(context),
          ),
          Spacer(),
          IconButton(
            onPressed: () => print("null"),
            icon: Icon(Icons.chat_bubble),
            color: ProjectColor.red,
          )
        ],
      ),
    );
  }

  SizedBox NormalRow(BuildContext context, String baslik, String icerik) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Text(
            baslik,
            style: ProjectTextStyle.redSmallStrong(context),
          ),
          Text(
            icerik,
            style: ProjectTextStyle.lightBlueSmallStrong(context),
          ),
        ],
      ),
    );
  }

  Row userTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ProfilePicture(radius: 60),
        Column(
          children: [
            Text(
              "Said Berk",
              style: ProjectTextStyle.lightBlueBigStrong(context),
            ),
            Text(
              "Aspar Enerji",
              style: ProjectTextStyle.redMediumStrong(context),
            ),
          ],
        )
      ],
    );
  }
}
