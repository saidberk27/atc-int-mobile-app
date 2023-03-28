import 'package:atc_international/data/local/user_name.dart';
import 'package:flutter/material.dart';

import '../data/viewmodel/login_vm.dart';
import '../screens/login/login.dart';
import 'colors.dart';
import 'custom_text_themes.dart';
import 'profile_picture.dart';

class ProjectSideNavMenu extends StatefulWidget {
  const ProjectSideNavMenu({super.key});

  @override
  State<ProjectSideNavMenu> createState() => _ProjectSideNavMenuState();
}

class _ProjectSideNavMenuState extends State<ProjectSideNavMenu> {
  late Future<String?> _userName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userName = UserName.getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _userName,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Expanded(
              flex: 2,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      ProfilePicture(
                        radius: 72,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        snapshot.data!,
                        style: ProjectTextStyle.darkBlueMediumStrong(context),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      menuItem(context,
                          text: "ANA SAYFA", icon: Icons.home_outlined),
                      menuItem(context,
                          text: "MÜŞTERİLERİM",
                          icon: Icons.people_alt_outlined,
                          route: "/customers"),
                      menuItem(context,
                          text: "AJANDA",
                          icon: Icons.business_center_outlined,
                          route: "/agenda"),
                      menuItem(context,
                          text: "KASALARIM",
                          icon: Icons.kitchen_rounded,
                          route: "/refrigerations"),
                      menuItem(context,
                          text: "MESAJLARIM", icon: Icons.message_outlined),
                      menuItem(context,
                          text: "ÇIKIŞ YAP",
                          icon: Icons.login_outlined,
                          isSignOut: true)
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  Padding menuItem(BuildContext context,
      {required String text,
      required IconData icon,
      String? route,
      bool isSignOut = false}) {
    route ?? (route = "/home");
    if (isSignOut) {
      return Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
        child: ListTile(
          onTap: () {
            LoginViewModel().signOut();
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => const LoginPage()),
              (Route<dynamic> route) => false,
            );
          },
          leading: Icon(
            icon,
            color: ProjectColor.lightBlue,
            size: 32,
          ),
          title: Text(text,
              style: ProjectTextStyle.darkMedium(context)
                  .copyWith(fontWeight: FontWeight.w500)),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
        child: ListTile(
          onTap: () => Navigator.pushNamed(context, route!),
          leading: Icon(
            icon,
            color: ProjectColor.lightBlue,
            size: 32,
          ),
          title: Text(text,
              style: ProjectTextStyle.darkMedium(context)
                  .copyWith(fontWeight: FontWeight.w500)),
        ),
      );
    }
  }
}
