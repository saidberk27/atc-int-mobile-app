import 'package:atc_international/data/local/current_user_data.dart';
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
        future: UserData.getCompleteUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.userPrivelege == "admin") {
              List<Widget> menuItems = [
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
                    text: "MESAJLARIM",
                    icon: Icons.message_outlined,
                    route: "/chats"),
                menuItem(context,
                    text: "ÇIKIŞ YAP",
                    icon: Icons.login_outlined,
                    isSignOut: true)
              ];
              return drawer(snapshot, context, companyName, menuItems);
            } else if (snapshot.data!.userPrivelege == "customer") {
              List<Widget> menuItems = [
                menuItem(context, text: "ANA SAYFA", icon: Icons.home_outlined),
                menuItem(context,
                    text: "AJANDA",
                    icon: Icons.business_center_outlined,
                    route: "/agenda"),
                menuItem(context,
                    text: "KASALARIM",
                    icon: Icons.kitchen_rounded,
                    route: "/refrigerations"),
                menuItem(context,
                    text: "MESAJLARIM",
                    icon: Icons.message_outlined,
                    route: "/chats"),
                menuItem(context,
                    text: "ÇIKIŞ YAP",
                    icon: Icons.login_outlined,
                    isSignOut: true)
              ];
              return drawer(snapshot, context, companyName, menuItems);
            } else if (snapshot.data!.userPrivelege == "worker") {
              List<Widget> menuItems = [
                menuItem(context, text: "ANA SAYFA", icon: Icons.home_outlined),
                menuItem(context,
                    text: "AJANDA",
                    icon: Icons.business_center_outlined,
                    route: "/agenda"),
                menuItem(context,
                    text: "İŞ TAKİP FORMLARIM",
                    icon: Icons.kitchen_rounded,
                    route: "/refrigerations"),
                menuItem(context,
                    text: "MESAJLARIM",
                    icon: Icons.message_outlined,
                    route: "/chats"),
                menuItem(context,
                    text: "ÇIKIŞ YAP",
                    icon: Icons.login_outlined,
                    isSignOut: true)
              ];
              return drawer(snapshot, context, companyName, menuItems);
            } else {
              List<Widget> menuItems = [
                menuItem(context, text: "Error", icon: Icons.error)
              ];
              return drawer(snapshot, context, companyName, menuItems);
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  Drawer drawer(AsyncSnapshot<CompleteUser?> snapshot, BuildContext context,
      String companyName, List<Widget> menuItems) {
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
                    snapshot.data!.userName,
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
              Column(children: menuItems)
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
