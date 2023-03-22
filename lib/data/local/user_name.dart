import 'package:atc_international/data/model/project_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserName {
  String? userId;
  String? currentUserName;
  String? currentUserId;
  late Map currentUser;
  var box;

  Future<void> saveUsernameFromRemoteToLocal({required userId}) async {
    box = await Hive.openBox('userBox');
    currentUser = await ProjectFirestore().getUser(userId: userId!);

    box.put('name', currentUser["user_name"]);
    box.put('id', userId);
  }

  Future<String?> getUserName() async {
    await Future.delayed(const Duration(milliseconds: 100));
    box = await Hive.openBox('userBox');
    currentUserName = await box.get('name');

    return currentUserName;
  }

  Future<String?> getUserId() async {
    await Future.delayed(const Duration(milliseconds: 500));
    box = await Hive.openBox('userBox');
    currentUserId = await box.get('id');

    return currentUserId;
  }
}
