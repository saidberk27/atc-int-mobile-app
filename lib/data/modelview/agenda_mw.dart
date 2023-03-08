//This class is a middle layer between view and models.
import 'package:atc_international/local_components/get_today.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../model/project_firestore.dart';

class AgendaModelView {
  late String taskName;
  late String taskDescription;
  late String deadEnd;

  List modelsList = [];
  ProjectFirestore db = ProjectFirestore();
  Future<List> getCompletedTasks() async {
    var completedTasks = await db.readDocumentFromDatabase(
        collection: "agenda", document: "completed");
    for (int i = 0; i < completedTasks.length; i++) {
      modelsList.add(AgendaTask.fromJson(
          json: completedTasks[i])); //it creates models and adds to list.
    }
    return modelsList;
  }

  void removeTaskFromDatabase({required String id}) {
    ProjectFirestore().removeFromDatabase(id: id);
  }
}

class AgendaTask {
  String? taskName;
  String? taskDescription;
  String? deadEnd;
  String? taskAdded;
  String? taskId;

  AgendaTask.toJson(
      {required String this.taskName,
      required String this.taskDescription,
      required String this.deadEnd}) {
    DateTime taskAddedDateTime = DateTime.parse(Time.getTimeStamp());
    Timestamp addTimeStamp = Timestamp.fromDate(taskAddedDateTime);

    DateTime deadEndDateTime = DateTime.parse(deadEnd!);
    Timestamp deadEndTimeStamp = Timestamp.fromDate(deadEndDateTime);

    final task = <String, dynamic>{
      "task_name": taskName,
      "task_description": taskDescription,
      "task_added": addTimeStamp,
      "dead_end": deadEndTimeStamp
    };

    ProjectFirestore().writeToDocument(json: task);
  }

  AgendaTask.fromJson({required Map json}) {
    var formatter = DateFormat('dd/MM/yyyy');
    taskId = json["id"];
    taskName = json["task_name"];
    taskDescription = json["task_description"];
    deadEnd = formatter.format(json["dead_end"]
        .toDate()); // Timestamp to DateTime to String conversion
    taskAdded = formatter.format(json["task_added"].toDate());
  }
}
