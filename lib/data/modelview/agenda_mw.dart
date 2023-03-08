//This class is a middle layer between view and models.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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
  String? deadEnd;
  String? taskAdded;

  AgendaTask.fromJson({required Map json}) {
    var formatter = DateFormat('dd/MM/yyyy');

    taskName = json["task_name"];
    taskDescription = json["task_description"];
    deadEnd = formatter.format(json["dead_end"].toDate());
    taskAdded = formatter.format(json["task_added"].toDate());
    //deadEnd = json["dead_end"];
    //taskAdded = json["task_added"];
  }
}
