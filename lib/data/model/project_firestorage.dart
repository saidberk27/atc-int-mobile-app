import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class ProjectFireStorage {
  final storageRef = FirebaseStorage.instance.ref();

  Future<String> uploadFile(File file) async {
    final fileRef = storageRef.child(file.path);

    try {
      await fileRef.putFile(file);
      return fileRef.getDownloadURL();
    } catch (e) {
      print(e);
      return "";
    }
  }
}
