import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDB {
  String? emailAddress;
  String? password;
  AuthRemoteDB({this.emailAddress, this.password});
  Future<String?> signInRemoteDB() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress!, password: password!);

      return credential
          .user?.uid; //It will return user id only if sign in succesfull
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        return "Wrong password provided for that user.";
      }
    }
  }

  Future<void> signOutRemoteDB() async {
    FirebaseAuth.instance.signOut();
  }
}
