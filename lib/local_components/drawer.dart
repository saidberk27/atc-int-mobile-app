import 'package:atc_international/local_components/colors.dart';
import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:flutter/material.dart';
import 'profile_picture.dart';

class ProjectDrawer extends StatelessWidget {
  const ProjectDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String name = "Ahmet";
    String surname = "Yılmaz";
    String companyName = "ATC INTERNATIONAL";

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
                    name,
                    style: ProjectTextStyle.darkMediumStrong(context),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    surname,
                    style: ProjectTextStyle.lightBlueMediumStrong(context),
                  )
                ],
              ),
              Text(
                companyName,
                style: ProjectTextStyle.redSmallStrong(context),
              ),
              menuItem(context, text: "ANA SAYFA", icon: Icons.home_outlined),
              menuItem(context,
                  text: "MÜŞTERİLERİM", icon: Icons.people_alt_outlined),
              menuItem(context,
                  text: "AJANDA", icon: Icons.business_center_outlined),
              menuItem(context, text: "KASALARIM", icon: Icons.kitchen_rounded),
              menuItem(context,
                  text: "MESAJLARIM", icon: Icons.message_outlined),
              menuItem(context, text: "ÇIKIŞ YAP", icon: Icons.login_outlined)
            ],
          ),
        ),
      ),
    );
  }

  Padding menuItem(BuildContext context,
      {required String text, required IconData icon, String? route}) {
    route ?? (route = "/home");
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
