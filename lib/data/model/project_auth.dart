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
    return null;
  }

  Future<void> signOutRemoteDB() async {
    FirebaseAuth.instance.signOut();
  }

  Future<String> createCustomerUser(
      {required String userEmail,
      required String userPassword,
      required String userName}) async {
    try {
      final auth = FirebaseAuth.instance;
      // Kullanıcıyı Firebase Authentication'a kaydedin.
      final userCrediental = await auth.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword);
      final user = userCrediental.user;
      final userID = user!.uid;

      print('Kullanıcı oluşturuldu: $userID');
      return userID;
    } catch (e) {
      print('Hata oluştu: $e');
      return 'Hata oluştu: $e';
    }
  }
}
