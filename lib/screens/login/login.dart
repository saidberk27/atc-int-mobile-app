import 'package:atc_international/data/local/current_user_data.dart';
import 'package:atc_international/data/viewmodel/login_vm.dart';
import 'package:atc_international/local_components/colors.dart';
import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:atc_international/screens/home_screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../local_components/slide_up_page_route.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey _formKey = GlobalKey();

  bool passwordVisibility = false;
  @override
  Widget build(BuildContext context) {
    const String logo = 'assets/svg/logo-atcint.svg';
    const String wellcomeMessage = "Hoş Geldiniz!";
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 1100) {
        return webScaffold(
            screenWidth, screenHeight, logo, wellcomeMessage, context);
      } else {
        return mobileScaffold(
            screenWidth, screenHeight, logo, wellcomeMessage, context);
      }
    });
  }

  Scaffold mobileScaffold(double screenWidth, double screenHeight, String logo,
      String wellcomeMessage, BuildContext context) {
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

  Scaffold webScaffold(double screenWidth, double screenHeight, String logo,
      String wellcomeMessage, BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: screenHeight / 6),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth / 4),
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

  Future<void> _signIn(context) async {
    late String snackBarText;
    late String userId;
    late String? userName;
    LoginViewModel login = LoginViewModel();
    String? response = await login.signInWithEmailandPassword(
        emailAdress: _emailController.text, password: _passwordController.text);

    if (response == "Böyle Bir Kullanıcı Kayıtlı Değil." ||
        response == "Parola Hatalı." ||
        response == null) {
      response == null
          ? snackBarText = "Lütfen Geçerli Bir Şekilde Doldurun."
          : snackBarText = response;
    } else {
      userId = response;
      UserData user = UserData();
      if (await user.saveUserDataFromRemoteToLocal(userId: userId)) {
        snackBarText = "Giriş Başarılı ...";
        Navigator.pushAndRemoveUntil(
          context,
          SlideUpPageRoute(page: const MyHomePage()),
          (route) => false,
        );
      }
    }

    SnackBar snackBar = SnackBar(
      content: Text(snackBarText),
      duration: const Duration(milliseconds: 1500),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  TextButton signInButton(
      double screenHeight, double screenWidth, BuildContext context) {
    return TextButton(
      onPressed: () => _signIn(context),
      style: ButtonStyle(
          shape: MaterialStateProperty.all(const StadiumBorder()),
          backgroundColor: MaterialStateProperty.all(ProjectColor.lightBlue)),
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
    );
  }

  InkWell forgotPassword(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint("Şifremi Unuttum");
      },
      child: SizedBox(
        height: 50,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "Şifrenizi mi unuttunuz?",
            style: ProjectTextStyle.redSmallStrong(context),
          ),
        ),
      ),
    );
  }

  Form formInputs(BuildContext context) {
    return Form(
      child: Column(
        key: _formKey,
        children: [emailInput(context), passwordInput(context)],
      ),
    );
  }

  Padding emailInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
      child: TextFormField(
        onFieldSubmitted: (value) => _signIn(context),
        obscureText: false,
        controller: _emailController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Lütfen bir değer girin.";
          } else if (value.length < 4) {
            return "Parola 3 karakterden fazla olmalıdır!";
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email_outlined),
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
    );
  }

  Padding passwordInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
      child: TextFormField(
        onFieldSubmitted: (value) => _signIn(context),
        controller: _passwordController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Lütfen bir değer girin.";
          } else if (value.length < 4) {
            return "Parola 3 karakterden fazla olmalıdır!";
          }
          return null;
        },
        obscureText: !passwordVisibility,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock_rounded),
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
          contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 24, 24, 24),
          suffixIcon: InkWell(
            onTap: () => setState(
              () => passwordVisibility = !passwordVisibility,
            ),
            focusNode: FocusNode(skipTraversal: true),
            child: Icon(
              !passwordVisibility
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: ProjectColor.darkBlue,
              size: 22,
            ),
          ),
        ),
        style: ProjectTextStyle.darkSmallStrong(context),
      ),
    );
  }
}
