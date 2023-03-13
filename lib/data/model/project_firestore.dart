import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProjectFirestore {
  var db = FirebaseFirestore.instance;

  void writeToDocument(
      {required collectionPath, required Map<String, dynamic> json}) {
    db.collection(collectionPath).add(json).then((DocumentReference doc) =>
        debugPrint('DocumentSnapshot added with ID: ${doc.id}'));
  }

  void removeFromDatabase({required String id}) {
    print("Removing...");
    db
        .collection("agenda")
        .doc("completed")
        .collection("Görev 1")
        .doc(id)
        .delete()
        .then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
  }

  Future<List<dynamic>> readDocumentsFromDatabase(
      {required String collectionPath}) async {
    var documents = [];

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

  Future<void> editDocument(
      {required String path,
      required String id,
      required var field,
      required var newData}) async {
    db.doc("$path/$id").update({field: newData});
  }

  Future<void> clearCollection({required String collectionPath}) async {
    db.collection(collectionPath).get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        if (ds["is_completed"]) {
          ds.reference.delete();
        }
      }
    });
  }
}
