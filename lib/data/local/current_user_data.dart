import 'package:atc_international/data/model/project_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserData {
  String? userId;
  String? currentUserName;
  String? currentUserId;
  late Map currentUser;
  late Box box;
  Future<void> saveUserDataFromRemoteToLocal({required userId}) async {
    box = await Hive.openBox('userBox');
    currentUser = await ProjectFirestore().getUser(userId: userId!);

    box.put('name', currentUser["user_name"]);
    box.put('id', userId);
    box.put('privelege', currentUser["user_privelege"]);
  }

  static Future<CompleteUser?> getCompleteUser() async {
    Box box;
    await Future.delayed(const Duration(milliseconds: 100));
    box = await Hive.openBox('userBox');

    String currentUserName = await box.get('name');
    String currentUserId = await box.get('id');
    String currentUserPrivelege = await box.get('privelege');

    CompleteUser completeUser = CompleteUser(
        userName: currentUserName,
        userID: currentUserId,
        userPrivelege: currentUserPrivelege);

    return completeUser;
  } //TODO getUserName ve diğer get methodlarını sil.

  static Future<String?> getUserName() async {
    String? currentUserName;

    Box box;
    await Future.delayed(const Duration(milliseconds: 100));
    box = await Hive.openBox('userBox');
    currentUserName = await box.get('name');

    return currentUserName;
  }

  static Future<String?> getUserId() async {
    Box box;

    String? currentUserId;
    await Future.delayed(const Duration(milliseconds: 500));
    box = await Hive.openBox('userBox');
    currentUserId = await box.get('id');

    return currentUserId;
  }

  static Future<String?> getUserPrivelege() async {
    Box box;
    String currentUserPrivelege;
    await Future.delayed(const Duration(milliseconds: 500));
    box = await Hive.openBox('userBox');
    currentUserPrivelege = await box.get('privelege');
    return currentUserPrivelege;
  }
}

class CompleteUser {
  String userName;
  String userID;
  String userPrivelege;

  CompleteUser(
      {required this.userName,
      required this.userID,
      required this.userPrivelege});
}
