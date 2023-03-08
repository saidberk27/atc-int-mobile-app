//This class is a middle layer between view and models.
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/project_firestore.dart';

class AgendaModelView {
  List modelsList = [];
  ProjectFirestore db = ProjectFirestore();
  Future<List> getCompletedTasks() async {
    var completedTasks = await db.readDocumentFromDatabase(
        collection: "agenda", document: "completed");
    for (int i = 0; i < completedTasks.length; i++) {
      modelsList.add(AgendaTask.fromJson(json: completedTasks[i]));
    }
    return modelsList;
  }
}

class AgendaTask {
  String? taskName;
  String? taskDescription;
  Timestamp? deadEnd;
  Timestamp? taskAdded;

  AgendaTask.fromJson({required Map json}) {
    taskName = json["task_name"];
    taskDescription = json["task_description"];
    deadEnd = json["Dead End"];
    taskAdded = json["taskAdded"];
  }
}
