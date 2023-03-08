import 'package:atc_international/data/model/project_firestore.dart';
import 'package:atc_international/local_components/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:intl/intl.dart';
import 'package:atc_international/local_components/drawer.dart';
import 'package:atc_international/local_components/profile_picture.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String logo = 'assets/svg/logo-atcint.svg';

  final String wellcomeMessage = "Hoş Geldin,\t\t";

  final String userName = "Ahmet";

  String today = "";

  @override
  void initState() {
    today = getToday();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
      drawer: const ProjectDrawer(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            buildLogo(screenHeight, screenWidth),
            buildUserandDateSection(context),
            const Divider(
              thickness: 2,
            ),
            buildMenu(),
            ElevatedButton(
                onPressed: () {
                  ProjectFirestore().testData();
                },
                child: const Text("Database Test"))
          ],
        ),
      )),
    );
  }

  Column buildMenu() {
    ListTile buildListTile({
      required String tileText,
      required TextStyle tileTextStyle,
      required Color tileColor,
      String? tileRoute,
      Color? iconColor,
    }) {
      tileRoute ?? (tileRoute = "/");
      return ListTile(
          onTap: () => Navigator.pushNamed(context, tileRoute!),
          title: Text(
            tileText,
            style: tileTextStyle,
          ),
          tileColor: tileColor,
          contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: (iconColor == null) ? ProjectColor.white : iconColor,
          ));
    }

    return Column(
      children: [
        buildListTile(
            tileText: "MÜŞTERİLERİM",
            tileTextStyle: ProjectTextStyle.whiteMediumStrong(context),
            tileColor: ProjectColor.red,
            tileRoute: "/customers"),
        buildListTile(
            tileText: "AJANDA",
            tileTextStyle: ProjectTextStyle.darkBlueMediumStrong(context),
            tileColor: ProjectColor.white,
            iconColor: ProjectColor.darkBlue,
            tileRoute: "/agenda"),
        buildListTile(
            tileText: "KASALARIM",
            tileTextStyle: ProjectTextStyle.whiteMediumStrong(context),
            tileColor: ProjectColor.lightBlue,
            tileRoute: "/refrigerations"),
        buildListTile(
          tileText: "MESAJLARIM",
          tileTextStyle: ProjectTextStyle.whiteMediumStrong(context),
          tileColor: ProjectColor.red,
        ),
        buildListTile(
            tileText: "ÇIKIŞ YAP",
            tileTextStyle: ProjectTextStyle.darkBlueMediumStrong(context),
            tileColor: ProjectColor.white,
            iconColor: ProjectColor.darkBlue),
      ],
    );
  }

  Padding buildUserandDateSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ProfilePicture(radius: 23),
          Row(
            children: [
              Text(
                wellcomeMessage,
                style: ProjectTextStyle.lightBlueMedium(context),
              ),
              Text(userName, style: ProjectTextStyle.redMedium(context)),
            ],
          ),
          Text(
            today,
            style: ProjectTextStyle.darkSmall(context),
          )
        ],
      ),
    );
  }

  Stack buildLogo(double screenHeight, double screenWidth) {
    return Stack(children: [
      Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: screenHeight / 5,
          width: screenWidth / 1.2,
          child: SvgPicture.asset(
            logo,
          ),
        ),
      ),
      Align(
          alignment: const Alignment(0.95, 1),
          child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/notifications");
              },
              icon: Icon(
                Icons.notifications,
                size: 36,
                color: ProjectColor.red,
              )))
    ]);
  }

  String getToday() {
    var now = DateTime.now();
    var formatter = DateFormat('dd/MM/yyyy');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }
}
