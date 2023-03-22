import 'package:atc_international/data/viewmodel/login_vm.dart';
import 'package:atc_international/local_components/colors.dart';
import 'package:atc_international/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:atc_international/local_components/drawer.dart';
import 'package:atc_international/local_components/profile_picture.dart';

import '../../data/local/user_name.dart';
import '../../local_components/get_today.dart';
import 'package:atc_international/local_components/nav_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String logo = 'assets/svg/logo-atcint.svg';

  final String wellcomeMessage = "Hoş Geldin,\t\t";

  late String userName;

  String today = "";

  @override
  void initState() {
    today = Time.getToday();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1000) {
          return webScaffold(screenHeight, screenWidth, context);
        } else {
          return mobileScaffold(screenHeight, screenWidth, context);
        }
      },
    );
  }

  Scaffold webScaffold(
      double screenHeight, double screenWidth, BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        children: [
          const ProjectSideNavMenu(),
          Expanded(
            flex: 8,
            child: SafeArea(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  buildLogo(screenHeight, screenWidth),
                  buildUserandDateSection(context),
                  const Divider(
                    thickness: 2,
                  ),
                  buildMenu(),
                ],
              ),
            )),
          ),
        ],
      ),
    );
  }

  Scaffold mobileScaffold(
      double screenHeight, double screenWidth, BuildContext context) {
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
          ],
        ),
      )),
    );
  }

  Column buildMenu() {
    ListTile buildListTile(
        {required String tileText,
        required TextStyle tileTextStyle,
        required Color tileColor,
        String? tileRoute,
        Color? iconColor,
        bool? isLogOut = false}) {
      tileRoute ?? (tileRoute = "/");
      if (isLogOut!) {
        return ListTile(
            onTap: _signOut,
            title: Text(
              tileText,
              style: tileTextStyle,
            ),
            tileColor: tileColor,
            contentPadding:
                const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: (iconColor == null) ? ProjectColor.white : iconColor,
            ));
      } else {
        return ListTile(
            onTap: () => Navigator.pushNamed(context, tileRoute!),
            title: Text(
              tileText,
              style: tileTextStyle,
            ),
            tileColor: tileColor,
            contentPadding:
                const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: (iconColor == null) ? ProjectColor.white : iconColor,
            ));
      }
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
            tileRoute: "/chats"),
        buildListTile(
            tileText: "ÇIKIŞ YAP",
            tileTextStyle: ProjectTextStyle.darkBlueMediumStrong(context),
            tileColor: ProjectColor.white,
            iconColor: ProjectColor.darkBlue,
            isLogOut: true),
      ],
    );
  }

  FutureBuilder buildUserandDateSection(BuildContext context) {
    return FutureBuilder(
        future: UserName().getUserName(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
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
                        wellcomeMessage, //connection staete == done yap
                        style: ProjectTextStyle.lightBlueSmall(context)
                            .copyWith(fontSize: 20),
                      ),
                      Text(snapshot.data,
                          style: ProjectTextStyle.redSmallStrong(context)
                              .copyWith(fontSize: 20)),
                    ],
                  ),
                  Text(
                    today,
                    style: ProjectTextStyle.darkSmall(context),
                  )
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
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
              icon: const Icon(
                Icons.notifications,
                size: 36,
                color: ProjectColor.red,
              )))
    ]);
  }

  void _signOut() {
    LoginViewModel().signOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
      (Route<dynamic> route) => false,
    );
  }
}
