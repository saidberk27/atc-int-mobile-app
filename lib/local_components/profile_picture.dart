import 'package:flutter/material.dart';
import 'package:atc_international/local_components/colors.dart';

class ProfilePicture extends StatelessWidget {
  ProfilePicture({
    required this.radius,
    super.key,
    String? profilePicture,
  }) {
    profilePicture == null
        ? this.profilePicture = 'assets/images/profile-blank.png'
        : this.profilePicture = profilePicture;
  }
  final double radius;
  late final String? profilePicture;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: ProjectColor.red,
      child: CircleAvatar(
          radius: (radius -
              3), // inner circle has 3 less radius due to border view.
          backgroundImage: ExactAssetImage(profilePicture!)),
    );
  }
}
