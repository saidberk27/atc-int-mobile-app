import 'package:atc_international/local_components/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String title = "Ana Sayfa";

  final String logo = 'assets/svg/logo-atcint.svg';

  final String profilePicture = 'assets/images/profile-blank.png';

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
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            buildLogo(screenHeight, screenWidth),
            buildUserandDateSection(context),
            const Divider(
              thickness: 2,
            ),
            buildMenu()
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
      Color? iconColor,
    }) {
      return ListTile(
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
        ),
        buildListTile(
            tileText: "İŞ EMİRLERİM",
            tileTextStyle: ProjectTextStyle.darkBlueMediumStrong(context),
            tileColor: ProjectColor.white,
            iconColor: ProjectColor.darkBlue),
        buildListTile(
          tileText: "KASALARIM",
          tileTextStyle: ProjectTextStyle.whiteMediumStrong(context),
          tileColor: ProjectColor.lightBlue,
        ),
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
          CircleAvatar(
            radius: 23,
            backgroundColor: ProjectColor.red,
            child: CircleAvatar(
                radius: 20, backgroundImage: ExactAssetImage(profilePicture)),
          ),
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
              onPressed: () {},
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
