//This class is a middle layer between view and models.

import 'package:atc_international/data/local/current_user_data.dart';
import 'package:atc_international/local_components/get_today.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../model/project_firestore.dart';

class AgendaViewModel {
  late String taskName;
  late String taskDescription;
  late String deadEnd;

  List modelsList = [];
  ProjectFirestore db = ProjectFirestore();
  Future<List> getTasks({required bool isCompleted}) async {
    String? userID = await UserData.getUserId();
    var tasks = await db.readDocumentsFromDatabaseWithCondition(
        collectionPath: "/users/$userID/agenda",
        conditionField: "is_completed",
        equalityValue:
            isCompleted); // if isCompleted passed as a false, then  the documents has "is_completed == false" field will be listed, otherwise "true" will be listed.
    for (int i = 0; i < tasks.length; i++) {
      modelsList.add(AgendaTask.fromJson(
          json: tasks[i])); //it creates models and adds to list.
    }
    return modelsList;
  }

  Future<void> completeTask({required String id}) async {
    String? userID = await UserData.getUserId();

    DateTime completionDateTime = DateTime.parse(Time.getTimeStamp());
    Timestamp completionTimeStamp = Timestamp.fromDate(completionDateTime);

    ProjectFirestore projectFireStore = ProjectFirestore();
    projectFireStore.editDocumentField(
        path: "/users/$userID/agenda",
        id: id,
        field: "is_completed",
        newData: true);

    projectFireStore.editDocumentField(
        path: "users/$userID/agenda",
        id: id,
        field: "completion_date",
        newData: completionTimeStamp);
  }

  Future<void> clearTasks() async {
    String? userID = await UserData.getUserId();

    ProjectFirestore().clearCollection(
        collectionPath: "/users/$userID/agenda",
        conditionField: "is_completed");
  }

  void removeTaskFromDatabase({required String id}) async {
    String? userID = await UserData.getUserId();

    ProjectFirestore()
        .removeFromDatabase(documentPath: "/users/$userID/agenda", id: id);
  }

  Future<void> saveTask(
      {required String taskName,
      required String taskDescription,
      required String deadEnd}) async {
    String? userID = await UserData.getUserId();

    AgendaTask.toJson(
        taskName: taskName,
        taskDescription: taskDescription,
        deadEnd: deadEnd,
        userID: userID!);
  }
}

class AgendaTask {
  //Program creates objects to add list here.
  String? taskName;
  String? taskDescription;
  String? deadEnd;
  String? taskAdded;
  String? taskId;
  String? taskCompleted;

  AgendaTask.toJson(
      {required String this.taskName,
      required String this.taskDescription,
      required String this.deadEnd,
      required String userID}) {
    DateTime taskAddedDateTime = DateTime.parse(Time.getTimeStamp());
    Timestamp addTimeStamp = Timestamp.fromDate(taskAddedDateTime);

    DateTime deadEndDateTime = DateTime.parse(deadEnd!);
    Timestamp deadEndTimeStamp = Timestamp.fromDate(deadEndDateTime);

    final task = <String, dynamic>{
      "task_name": taskName,
      "task_description": taskDescription,
      "task_added": addTimeStamp,
      "dead_end": deadEndTimeStamp,
      "is_completed": false
    };

    ProjectFirestore()
        .addDocumentToCollection(path: "/users/$userID/agenda", json: task);
  }

  AgendaTask.fromJson({required Map json}) {
    var formatter = DateFormat('dd/MM/yyyy');
    taskId = json["id"];
    taskName = json["task_name"];
    taskDescription = json["task_description"];
    deadEnd = formatter.format(json["dead_end"].toDate());
    try {
      taskCompleted = formatter.format(json["completion_date"].toDate());
    } catch (e) {
      taskCompleted = "Henüz Tamamlanmadı";
    }
    // Timestamp to DateTime to String conversion
    taskAdded = formatter.format(json["task_added"].toDate());
  }
}
