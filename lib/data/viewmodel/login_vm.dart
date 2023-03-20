import '../model/project_auth.dart';

class LoginViewModel {
  String? emailAdress;
  String? password;
  String? signInResponse;
  String? userId;
  AuthRemoteDB? db;

  Map exceptionMap = <String, bool>{
    "Wrong password provided for that user.": false,
    "No user found for that email.": false
  };

  Future<String?> signInWithEmailandPassword(
      {required emailAdress, required password}) async {
    AuthRemoteDB db = AuthRemoteDB(
      emailAddress: emailAdress,
      password: password,
    );
    signInResponse = await db.signInRemoteDB();
    switch (signInResponse) {
      case "No user found for that email.":
        return "Böyle Bir Kullanıcı Kayıtlı Değil.";

      case "Wrong password provided for that user.":
        return "Parola Hatalı.";

      default:
        userId = signInResponse;
        return signInResponse;
    }
  }
}
