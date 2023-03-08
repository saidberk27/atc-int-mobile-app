import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProjectFirestore {
  var db = FirebaseFirestore.instance;

  void writeToDocument({required Map<String, dynamic> json}) {
    db
        .collection("agenda")
        .doc("completed")
        .collection("Görev 1")
        .add(json)
        .then((DocumentReference doc) =>
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

  Future<List<dynamic>> readDocumentFromDatabase(
      {required String collection, required String document}) async {
    var documents = [];

    final ref = db.collection(collection).doc(document).collection("Görev 1");
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
}
