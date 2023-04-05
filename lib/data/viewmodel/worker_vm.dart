import 'package:atc_international/data/local/current_user_data.dart';
import 'package:atc_international/data/model/project_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../local_components/get_today.dart';
import '../model/project_firestore.dart';

class WorkerViewModel {
  List modelsList = [];
  ProjectFirestore db = ProjectFirestore();
  Future<List> getWorkers() async {
    String? userID = await UserData.getUserId();

    //gets json and converts to datamodel.
    var workers = await db.readDocumentsFromDatabaseWithOrder(
        collectionPath: "/users/$userID/workers/",
        orderField: "worker_added",
        isDescending: false);
    for (int i = 0; i < workers.length; i++) {
      modelsList.add(Worker.fromJson(json: workers[i]));
    }
    return modelsList;
  }

  Future<void> saveWorker(
      {required String workerName,
      required String workerCompany,
      required String workerTitle,
      required String workerMail,
      required String workerPassword,
      required String workerPhone}) async {
    String? currentUserID = await UserData.getUserId();

    String createdUserID = await AuthRemoteDB().createUser(
        userEmail: workerMail,
        userPassword: workerPassword,
        userName: workerName);
    Worker.toJson(
        workerName: workerName,
        workerCompany: "ATC International",
        workerTitle: workerTitle,
        workerMail: workerMail,
        workerPassword: workerPassword,
        workerPhone: workerPhone,
        id: createdUserID,
        userID: currentUserID!);
  }

  Future<void> deleteWorker({required String id}) async {
    String? userID = await UserData.getUserId();

    db.removeFromDatabase(documentPath: "users/$userID/workers", id: id);
//TODO Worker firestoer workers'den siliniyor. fakat id farklı oldugu icin ayni worker users'dan silinmiyor. Ayrıca hesap da kaldırılmıyor auth sistemden
  }
}

class Worker {
  String? workerName;
  String? workerCompany;
  String? workerTitle;
  String? workerMail;
  String? workerPassword;
  String? workerPhone;
  String? id;
  Timestamp? workerTimeStamp;
  Worker.toJson(
      {required String this.workerName,
      required String this.workerCompany,
      required String this.workerTitle,
      required String this.workerMail,
      required String this.workerPassword,
      required String this.workerPhone,
      required String this.id,
      required String userID}) {
    DateTime workerAddedDate = DateTime.parse(Time.getTimeStamp());
    Timestamp workerTimeStamp = Timestamp.fromDate(workerAddedDate);

    final worker = <String, dynamic>{
      "worker_name": workerName,
      "worker_company": "ATC Int.",
      "worker_title": workerTitle,
      "worker_mail":
          workerMail, //Worker password will not be writed to firestore due to security reasons
      "worker_phone": workerPhone,
      "worker_added": workerTimeStamp
    };

    final user = <String, dynamic>{
      "user_name": workerName,
      "user_privelege": "worker",
    };

    ProjectFirestore()
        .addDocumentToCollectionWithID(path: "/users", json: user, ID: id!);

    ProjectFirestore().addDocumentToCollectionWithID(
        path: "/users/$userID/workers/", json: worker, ID: id!);
  }

  Worker.fromJson({required Map json}) {
    workerName = json["worker_name"];
    workerCompany = json["worker_company"];
    workerTitle = json["worker_title"];
    workerMail = json["worker_mail"];
    workerPhone = json["worker_phone"];
    workerTimeStamp = json["worker_added"];
    id = json["id"];
    // Timestamp to DateTime to String conversion
  }
}