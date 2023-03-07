import 'package:atc_international/local_components/colors.dart';
import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    String title = "BİLDİRİMLER";
    //String zeroNotificationMessage = "Hiç bildiriminiz yok :)";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: ProjectTextStyle.redMediumStrong(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            border: Border.all(color: ProjectColor.red, width: 3)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
            child: ListView(
              children: [
                ListTile(
                  title: Text(
                    "Yeni Mesaj",
                    style: ProjectTextStyle.redMedium(context),
                  ),
                  subtitle: Text(
                    "Said Berk'ten yeni mesaj",
                    style: ProjectTextStyle.lightBlueSmallStrong(context),
                  ),
                  trailing: Icon(
                    Icons.arrow_right,
                    color: ProjectColor.red,
                  ),
                ),
                ListTile(
                  title: Text(
                    "Yeni Mesaj",
                    style: ProjectTextStyle.redMedium(context),
                  ),
                  subtitle: Text(
                    "Said Berk'ten yeni mesaj",
                    style: ProjectTextStyle.lightBlueSmallStrong(context),
                  ),
                  trailing: Icon(
                    Icons.arrow_right,
                    color: ProjectColor.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
