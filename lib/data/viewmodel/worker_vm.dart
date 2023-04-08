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

  Future<void> addForm({required JobForm jobForm}) async {
    String? userID = await UserData.getUserId();

    Map<String, dynamic> json = JobForm.toJson(jobForm: jobForm);
    db.addDocumentToCollection(json: json, path: "users/$userID/forms");
  }

  Future<List> getJobForms() async {
    String? userID = await UserData.getUserId();

    List forms = await db.readDocumentsFromDatabaseWithOrder(
        collectionPath: "users/$userID/forms",
        orderField: "timestamp",
        isDescending: false);

    return forms;
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

class JobForm {
  late String customerName;
  late String fridgeNo;
  late String vehiclePlateAndInfo;
  late String arrivalTime;
  late String leaveTime;
  late String finishDate;
  late String partsMustChange;
  late String vehicleHealthStatus;
  late String otherComments;

  late bool coldenGeneralControl;
  late bool compressor;
  late bool gasControl;
  late bool condensator;

  late bool gasLeakControl;
  late bool honeyComb;
  late bool connectionControls;
  late bool allConnectionPipesControls;

  late bool sidePanels;
  late bool frontPanel;
  late bool floorPanel;
  late bool floorDrenage;
  late bool panelHoneycombConnectionStatus;
  late bool fridgeIsolationStatus;
  late bool fridgeInnerOuterElectricityControl;
  late bool fridgeDoorConnectionControl;
  late bool fridgeConnectionScrewControl;

  late bool doorIsolationStatus;
  late bool doorPlastic;
  late bool locks;
  late bool rearDoorFrameStatus;
  late bool rearDoorStands;

  late bool floor;
  late bool honeycombs;
  late bool pipes;
  late bool innerSeperations;
  late bool lights;
  late bool roofAndOthers;

  late bool approveForm;

  JobForm({
    required this.customerName,
    required this.fridgeNo,
    required this.vehiclePlateAndInfo,
    required this.arrivalTime,
    required this.leaveTime,
    required this.finishDate,
    required this.partsMustChange,
    required this.vehicleHealthStatus,
    required this.otherComments,
    required this.coldenGeneralControl,
    required this.compressor,
    required this.gasControl,
    required this.condensator,
    required this.gasLeakControl,
    required this.honeyComb,
    required this.connectionControls,
    required this.allConnectionPipesControls,
    required this.sidePanels,
    required this.frontPanel,
    required this.floorPanel,
    required this.floorDrenage,
    required this.panelHoneycombConnectionStatus,
    required this.fridgeIsolationStatus,
    required this.fridgeInnerOuterElectricityControl,
    required this.fridgeDoorConnectionControl,
    required this.fridgeConnectionScrewControl,
    required this.doorIsolationStatus,
    required this.doorPlastic,
    required this.locks,
    required this.rearDoorFrameStatus,
    required this.rearDoorStands,
    required this.floor,
    required this.honeycombs,
    required this.pipes,
    required this.innerSeperations,
    required this.lights,
    required this.roofAndOthers,
    required bool this.approveForm,
  });

  static Map<String, dynamic> toJson({required JobForm jobForm}) {
    String dateStr = Time.getTimeStamp();
    DateTime timeStamp = DateTime.parse(dateStr);
    final jobFormJson = <String, dynamic>{
      "customer": jobForm.customerName,
      "fridge_no": jobForm.fridgeNo,
      "vehicle_plate_and_info": jobForm.vehiclePlateAndInfo,
      "arrival_time": jobForm.arrivalTime,
      "leave_time": jobForm.leaveTime,
      "finish_date": jobForm.finishDate,
      "parts_must_change": jobForm.partsMustChange,
      "vehicle_health_status": jobForm.vehicleHealthStatus,
      "other_comments": jobForm.otherComments,
      "timestamp": timeStamp,
      "colden_unit": {
        "coldenGeneralControl": jobForm.coldenGeneralControl,
        "compressor": jobForm.compressor,
        "gasControl": jobForm.gasControl,
        "condensator": jobForm.condensator,
      },
      "honey_combs": {
        "gasLeakControl": jobForm.gasLeakControl,
        "honeyComb": jobForm.honeyComb,
        "connectionControls": jobForm.connectionControls,
        "allConnectionPipesControls": jobForm.allConnectionPipesControls,
      },
      "all_panels": {
        "sidePanels": jobForm.sidePanels,
        "frontPanel": jobForm.frontPanel,
        "floorPanel": jobForm.floorPanel,
        "floorDrenage": jobForm.floorDrenage,
        "panelHoneycombConnectionStatus":
            jobForm.panelHoneycombConnectionStatus,
        "fridgeIsolationStatus": jobForm.fridgeIsolationStatus,
        "fridgeInnerOuterElectricityControl":
            jobForm.fridgeInnerOuterElectricityControl,
        "fridgeDoorConnectionControl": jobForm.fridgeDoorConnectionControl,
        "fridgeConnectionScrewControl": jobForm.fridgeConnectionScrewControl,
      },
      "rear_door": {
        "doorIsolationStatus": jobForm.doorIsolationStatus,
        "doorPlastic": jobForm.doorPlastic,
        "locks": jobForm.locks,
        "rearDoorFrameStatus": jobForm.rearDoorFrameStatus,
        "rearDoorStands": jobForm.rearDoorStands,
      },
      "fridge_interior": {
        "floor": jobForm.floor,
        "honeycombs": jobForm.honeycombs,
        "pipes": jobForm.pipes,
        "innerSeperations": jobForm.innerSeperations,
        "lights": jobForm.lights,
        "roofAndOthers": jobForm.roofAndOthers,
      },
      "approveForm": jobForm.approveForm
    };

    return jobFormJson;
  }
}
