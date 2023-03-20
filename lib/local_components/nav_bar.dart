import 'package:flutter/material.dart';

import '../data/viewmodel/login_vm.dart';
import '../screens/login/login.dart';
import 'colors.dart';
import 'custom_text_themes.dart';
import 'profile_picture.dart';

class ProjectSideNavMenu extends StatelessWidget {
  const ProjectSideNavMenu({super.key});

  @override
  Widget build(BuildContext context) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "İsim",
                    style: ProjectTextStyle.darkMediumStrong(context),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Soyisim",
                    style: ProjectTextStyle.lightBlueMediumStrong(context),
                  )
                ],
              ),
              Text(
                "Şirket İsmi",
                style: ProjectTextStyle.redSmallStrong(context),
              ),
              menuItem(context, text: "ANA SAYFA", icon: Icons.home_outlined),
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
              MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
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
