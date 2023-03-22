import 'package:atc_international/data/local/user_name.dart';
import 'package:atc_international/local_components/colors.dart';
import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:flutter/material.dart';
import '../data/viewmodel/login_vm.dart';
import '../screens/login/login.dart';
import 'profile_picture.dart';

class ProjectDrawer extends StatelessWidget {
  const ProjectDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String companyName = "ATC INTERNATIONAL";

    return FutureBuilder(
        future: UserName().getUserName(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Drawer(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      ProfilePicture(
                        radius: 72,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            snapshot.data!,
                            style: ProjectTextStyle.darkMediumStrong(context),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Text(
                        companyName,
                        style: ProjectTextStyle.redSmallStrong(context),
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
