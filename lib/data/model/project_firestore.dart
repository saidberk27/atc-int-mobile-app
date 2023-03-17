import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProjectFirestore {
  var db = FirebaseFirestore.instance;

  void writeToDocument(
      {required collectionPath, required Map<String, dynamic> json}) {
    db.collection(collectionPath).add(json).then((DocumentReference doc) =>
        debugPrint('DocumentSnapshot added with ID: ${doc.id}'));
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

    final ref = db
        .collection(collectionPath)
        .orderBy("customer_added", descending: true);
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
