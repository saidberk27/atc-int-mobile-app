import 'package:firebase_auth/firebase_auth.dart';
import 'project_firestore.dart';

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

  Future<void> createCustomerUser(
      {required String userEmail,
      required String userPassword,
      required String userName}) async {
    try {
      final _auth = FirebaseAuth.instance;
      // Kullanıcıyı Firebase Authentication'a kaydedin.
      await _auth.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword);
      print('Kullanıcı oluşturuldu.');
    } catch (e) {
      print('Hata oluştu: $e');
    }

    try {
      var db = ProjectFirestore();
      Map<String, dynamic> json = {"user_name": userName};
      db.addDocumentToCollection(json: json, path: "/users");
    } catch (e) {
      print("Hata $e");
    }
  }
}
