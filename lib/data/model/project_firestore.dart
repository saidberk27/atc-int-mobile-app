import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectFirestore {
  var db = FirebaseFirestore.instance;
  void testData() {
    // Create a new user with a first and last name
    final user = <String, dynamic>{
      "first": "Ada",
      "last": "Lovelace",
      "born": 1815
    };

// Add a new document with a generated ID
    db.collection("users").add(user).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));
  }

  Future<List<dynamic>> readDocumentFromDatabase(
      {required String collection, required String document}) async {
    var documents = [];

    final ref = db.collection(collection).doc(document).collection("Görev 1");
    QuerySnapshot querySnapshot = await ref.get();
    for (var docSnapshot in querySnapshot.docs) {
      documents.add(docSnapshot.data());
    }
    return documents;
  }
}
