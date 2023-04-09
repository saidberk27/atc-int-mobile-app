import 'package:atc_international/screens/refrigerations/refrigeration.dart';

import '../local/current_user_data.dart';
import '../model/project_firestore.dart';

class RefrigerationViewModel {
  ProjectFirestore db = ProjectFirestore();
  Future<List<dynamic>> getRefrigerations() async {
    List modelList = [];
    String? userID = await UserData.getUserId();
    var refrigerations = await db.readDocumentsFromDatabase(
        collectionPath: "/users/$userID/refrigerations");

    for (int i = 0; i < refrigerations.length; i++) {
      modelList.add(Refrigeration.fromJson(json: refrigerations[i]));
    }
    return modelList;
  }

  Future<void> addRefrigeration({required Refrigeration refrigeration}) async {
    String? userID = await UserData.getUserId();
    Map<String, dynamic> json =
        Refrigeration.toJson(refrigeration: refrigeration);
    db.addDocumentToCollection(
        path: "/users/$userID/refrigerations", json: json);
  }
/*   Future<void> editRefrigeration({required Refrigeration refrigeration}) async {
    String? userID = await UserData.getUserId();
    Map<String, dynamic> json =
        Refrigeration.toJson(refrigeration: refrigeration);
    db.editDocument(
        path: "/users/$userID/refrigerations", id: userID!, json: json);
  }*/

  Future<void> removeRefrigeration({required String id}) async {
    String? userID = await UserData.getUserId();

    db.removeFromDatabase(
        documentPath: "/users/$userID/refrigerations", id: id);
  }
}

class Refrigeration {
  ProjectFirestore db = ProjectFirestore();
  late final String caseBrand;
  late final String caseModel;
  late final String rearDoor;
  late final String serialNumber;
  late final String vehicleInformation;
  late final String compressorBrand;
  late final String compressorModel;
  late final String compressorStatus;
  late final String euteticPlateModel;
  late final String euteticPlateMeasurement;
  late final String euteticPlateNumber;
  late final String euteticPlateStatus;
  late final String interiorInstallationStatus;
  late final String gasStatus;
  late final String extraNotes;
  late final String id;

  static Map<String, dynamic> toJson({required Refrigeration refrigeration}) {
    final json = <String, dynamic>{
      "case_brand": refrigeration.caseBrand,
      "case_model": refrigeration.caseModel,
      "rear_door": refrigeration.rearDoor,
      "serial_number": refrigeration.serialNumber,
      "vehicle_information": refrigeration.vehicleInformation,
      "compressor_brand": refrigeration.compressorBrand,
      "compressor_model": refrigeration.compressorModel,
      "compressor_status": refrigeration.compressorStatus,
      "eutetic_plate_model": refrigeration.euteticPlateModel,
      "eutetic_plate_measurement": refrigeration.euteticPlateMeasurement,
      "eutetic_plate_number": refrigeration.euteticPlateNumber,
      "eutetic_plate_status": refrigeration.euteticPlateStatus,
      "interior_installation_status": refrigeration.interiorInstallationStatus,
      "gas_status": refrigeration.gasStatus,
      "extra_notes": refrigeration.extraNotes,
    };
    return json;
  }

  Refrigeration({
    required this.caseBrand,
    required this.caseModel,
    required this.rearDoor,
    required this.serialNumber,
    required this.vehicleInformation,
    required this.compressorBrand,
    required this.compressorModel,
    required this.compressorStatus,
    required this.euteticPlateModel,
    required this.euteticPlateMeasurement,
    required this.euteticPlateNumber,
    required this.euteticPlateStatus,
    required this.interiorInstallationStatus,
    required this.gasStatus,
    required this.extraNotes,
  });
  Refrigeration.fromJson({required Map json}) {
    caseBrand = json["case_brand"];
    caseModel = json["case_model"];
    rearDoor = json["rear_door"];
    serialNumber = json["serial_number"];
    vehicleInformation = json["vehicle_information"];
    compressorBrand = json["compressor_brand"];
    compressorModel = json["compressor_model"];
    compressorStatus = json["compressor_status"];
    euteticPlateModel = json["eutetic_plate_model"];
    euteticPlateMeasurement = json["eutetic_plate_measurement"];
    euteticPlateNumber = json["eutetic_plate_number"];
    euteticPlateStatus = json["eutetic_plate_status"];
    interiorInstallationStatus = json["interior_installation_status"];
    gasStatus = json["gas_status"];
    extraNotes = json["extra_notes"];
    id = json["id"];
  }
}
