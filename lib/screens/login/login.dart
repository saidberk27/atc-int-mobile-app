import 'package:atc_international/local_components/colors.dart';
import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisibility = false;
  @override
  Widget build(BuildContext context) {
    const String logo = 'assets/svg/logo-atcint.svg';
    const String wellcomeMessage = "Hoş Geldiniz!";
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight / 5,
                  width: screenWidth / 1.2,
                  child: SvgPicture.asset(
                    logo,
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Text(wellcomeMessage,
                        style: ProjectTextStyle.redMediumStrong(context))),
                formInputs(context),
                loginAndForgotPassword(context, screenHeight,
                    screenWidth) // Generated code for this password Widget...
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding loginAndForgotPassword(
      BuildContext context, double screenHeight, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 24.0, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          forgotPassword(context),
          signInButton(screenHeight, screenWidth, context)
        ],
      ),
    );
  }

  TextButton signInButton(
      double screenHeight, double screenWidth, BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: SizedBox(
        height: screenHeight / 16,
        width: screenWidth / 3.2,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "Giriş Yap",
            style: ProjectTextStyle.whiteSmallStrong(context),
          ),
        ),
      ),
      style: ButtonStyle(
          shape: MaterialStateProperty.all(StadiumBorder()),
          backgroundColor: MaterialStateProperty.all(ProjectColor.lightBlue)),
    );
  }

  GestureDetector forgotPassword(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint("Şifremi Unuttum");
      },
      child: Text(
        "Şifrenizi mi unuttunuz?",
        style: ProjectTextStyle.redSmallStrong(context),
      ),
    );
  }

  Form formInputs(BuildContext context) {
    return Form(
      child: Column(
        children: [emailInput(context), passwordInput(context)],
      ),
    );
  }

  Padding emailInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
      child: Expanded(
        child: TextFormField(
          obscureText: false,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.email_outlined),
            labelText: 'E - Posta Adresi',
            labelStyle: ProjectTextStyle.darkBlueSmallStrong(context),
            hintText: 'E-Posta\'nızı Buraya Girin...',
            hintStyle: ProjectTextStyle.darkSmall(context),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ProjectColor.lightBlue,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(40),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ProjectColor.darkBlue,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(40),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ProjectColor.lightBlue,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(40),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ProjectColor.lightBlue,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(40),
            ),
            contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
          ),
          style: ProjectTextStyle.darkSmallStrong(context),
        ),
      ),
    );
  }

  Padding passwordInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
      child: Expanded(
        child: TextFormField(
          obscureText: !passwordVisibility,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock_rounded),
            labelText: 'Şifre',
            labelStyle: ProjectTextStyle.darkBlueSmallStrong(context),
            hintText: 'Şifrenizi Buraya Girin...',
            hintStyle: ProjectTextStyle.darkSmall(context),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ProjectColor.lightBlue,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(40),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ProjectColor.lightBlue,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(40),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ProjectColor.lightBlue,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(40),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ProjectColor.lightBlue,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(40),
            ),
            contentPadding:
                const EdgeInsetsDirectional.fromSTEB(16, 24, 24, 24),
            suffixIcon: InkWell(
              onTap: () => setState(
                () => passwordVisibility = !passwordVisibility,
              ),
              focusNode: FocusNode(skipTraversal: true),
              child: Icon(
                passwordVisibility
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: ProjectColor.red,
                size: 22,
              ),
            ),
          ),
          style: ProjectTextStyle.darkSmallStrong(context),
        ),
      ),
    );
  }
}
