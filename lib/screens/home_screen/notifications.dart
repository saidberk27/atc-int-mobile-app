import 'package:atc_international/local_components/colors.dart';
import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    String title = "BİLDİRİMLER";
    String zeroNotificationMessage = "Hiç bildiriminiz yok :)";
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        decoration: BoxDecoration(
            border: Border.all(color: ProjectColor.red, width: 3)),
        child: Center(
          child: Text(
            zeroNotificationMessage,
            style: ProjectTextStyle.lightBlueMediumStrong(context),
          ),
        ),
      ),
    );
  }
}
