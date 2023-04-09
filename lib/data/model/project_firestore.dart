import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProjectFirestore {
  var db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getChatStream({required String chatID}) {
    var chatMaxLimit = 500;
    final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance
        .collection('/chats/$chatID/messages')
        .limit(chatMaxLimit)
        .orderBy("time", descending: true)
        .snapshots();
    return usersStream;
  }

  Future<void> addDocumentToCollection(
      {required Map<String, dynamic> json, required String path}) async {
    db.collection(path).add(json).then((documentSnapshot) {
      Map<Object, Object?> documentIDfield = {"id": documentSnapshot.id};
      db.collection(path).doc(documentSnapshot.id).update(documentIDfield);
      print("Added Data with ID: ${documentSnapshot.id}");
    });
  }

  Future<void> addDocumentToCollectionWithID(
      {required Map<String, dynamic> json,
      required String path,
      required String ID}) async {
    try {
      db.collection(path).doc(ID).set(json);
      debugPrint("Data SUccesfully Added.");
    } catch (e) {
      debugPrint("An error occured on add document $e");
    }
  }

  Future<Map> getUser({required String userId}) async {
    print(userId);
    DocumentSnapshot userDoc = await db.doc("/users/$userId").get();
    try {
      Map userData = userDoc.data() as Map<String, dynamic>;
      return userData;
    } catch (e) {
      debugPrint("Hata, $e");
      var userData = null;
      return userData;
    }
  }

  void removeFromDatabase({required String documentPath, required String id}) {
    debugPrint("Removing...");
    db.doc("$documentPath/$id").delete().then(
          (doc) => debugPrint("Document deleted"),
          onError: (e) => debugPrint("Error updating document $e"),
        );
  }

  Future<List<dynamic>> readDocumentsFromDatabase(
      {required String collectionPath}) async {
    List documents = [];

    final ref = db.collection(collectionPath);
    QuerySnapshot querySnapshot = await ref.get();
    for (var docSnapshot in querySnapshot.docs) {
      var documentMap = docSnapshot.data() as Map<String, dynamic>;
      var idMap = {
        "id": docSnapshot.reference.id
      }; // dosyanin id'sini ayrica alip bir sozluk olusturuyorum.
      documentMap.addAll(
          idMap); //sonra elimdeki asil sozlukun icine id'den yaptigim sozluku koyuyorum.
      //print(documentMap);
      documents.add(documentMap);
    }
    return documents;
  }

  Future<List<dynamic>> readDocumentsFromDatabaseWithOrder(
      {required String collectionPath,
      required String orderField,
      required bool isDescending}) async {
    List documents = [];

    final ref =
        db.collection(collectionPath).orderBy(orderField, descending: true);
    QuerySnapshot querySnapshot = await ref.get();
    for (var docSnapshot in querySnapshot.docs) {
      var documentMap = docSnapshot.data() as Map<String, dynamic>;
      var idMap = {
        "id": docSnapshot.reference.id
      }; // dosyanin id'sini ayrica alip bir sozluk olusturuyorum.
      documentMap.addAll(
          idMap); //sonra elimdeki asil sozlukun icine id'den yaptigim sozluku koyuyorum.
      //print(documentMap);
      documents.add(documentMap);
    }
    return documents;
  }

  Future<List<dynamic>> readDocumentsFromDatabaseWithCondition(
      {required String collectionPath,
      required String conditionField,
      var equalityValue}) async {
    var documents = [];

    final ref = db
        .collection(collectionPath)
        .where(conditionField, isEqualTo: equalityValue);
    QuerySnapshot querySnapshot = await ref.get();
    for (var docSnapshot in querySnapshot.docs) {
      var documentMap = docSnapshot.data() as Map<String, dynamic>;
      var idMap = {
        "id": docSnapshot.reference.id
      }; // dosyanin id'sini ayrica alip bir sozluk olusturuyorum.
      documentMap.addAll(
          idMap); //sonra elimdeki asil sozlukun icine id'den yaptigim sozluku koyuyorum.
      //print(documentMap);
      documents.add(documentMap);
    }
    return documents;
  }

  Future<void> editDocumentField(
      {required String path,
      required String id,
      required var field,
      required var newData}) async {
    db.doc("$path/$id").update({field: newData});
  }

  Future<void> clearCollection(
      {required String collectionPath, required String conditionField}) async {
    db.collection(collectionPath).get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        if (ds[conditionField]) {
          ds.reference.delete();
        }
      }
    });
  }
}
