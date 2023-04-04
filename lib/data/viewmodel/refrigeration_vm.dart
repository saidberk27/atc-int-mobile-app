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

  Future<void> addRefrigeration(
      {required String caseBrand,
      required String caseModel,
      String? rearDoor,
      String? serialNumber,
      String? vehicleInformation,
      String? compressorBrand,
      String? compressorModel,
      String? compressorStatus,
      String? euteticPlateModel,
      String? euteticPlateMeasurement,
      String? euteticPlateNumber,
      String? euteticPlateStatus,
      String? interiorInstallationStatus,
      String? gasStatus,
      String? extraNotes}) async {
    String? userID = await UserData.getUserId();

    rearDoor == null ? rearDoor = "Belirtilmedi." : rearDoor = rearDoor;

    vehicleInformation == null
        ? vehicleInformation = "Belirtilmedi."
        : vehicleInformation = vehicleInformation;

    serialNumber == null
        ? serialNumber = "Belirtilmedi."
        : serialNumber = serialNumber;

    compressorBrand == null
        ? compressorBrand = "Belirtilmedi."
        : compressorBrand = compressorBrand;

    compressorModel == null
        ? compressorModel = "Belirtilmedi."
        : compressorModel = compressorModel;

    compressorStatus == null
        ? compressorStatus = "Belirtilmedi."
        : compressorStatus = compressorStatus;

    euteticPlateModel == null
        ? euteticPlateModel = "Belirtilmedi."
        : euteticPlateModel = euteticPlateModel;

    euteticPlateMeasurement == null
        ? euteticPlateMeasurement = "Belirtilmedi."
        : euteticPlateMeasurement = euteticPlateMeasurement;

    euteticPlateNumber == null
        ? euteticPlateNumber = "Belirtilmedi."
        : euteticPlateNumber = euteticPlateNumber;

    euteticPlateStatus == null
        ? euteticPlateStatus = "Belirtilmedi."
        : euteticPlateStatus = euteticPlateStatus;

    interiorInstallationStatus == null
        ? interiorInstallationStatus = "Belirtilmedi."
        : interiorInstallationStatus = interiorInstallationStatus;

    gasStatus == null ? gasStatus = "Belirtilmedi." : gasStatus = gasStatus;

    extraNotes == null ? extraNotes = "Belirtilmedi." : extraNotes = extraNotes;

    Refrigeration.toJson(
        caseBrand: caseBrand,
        caseModel: caseModel,
        rearDoor: rearDoor,
        serialNumber: serialNumber,
        vehicleInformation: vehicleInformation,
        compressorBrand: compressorBrand,
        compressorModel: compressorModel,
        compressorStatus: compressorStatus,
        euteticPlateModel: euteticPlateModel,
        euteticPlateMeasurement: euteticPlateMeasurement,
        euteticPlateNumber: euteticPlateNumber,
        euteticPlateStatus: euteticPlateStatus,
        interiorInstallationStatus: interiorInstallationStatus,
        gasStatus: gasStatus,
        extraNotes: extraNotes,
        currentUserID: userID);
  }

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

  Refrigeration.toJson(
      {String? caseBrand,
      String? caseModel,
      String? serialNumber,
      String? rearDoor,
      String? vehicleInformation,
      String? compressorBrand,
      String? compressorModel,
      String? compressorStatus,
      String? euteticPlateModel,
      String? euteticPlateMeasurement,
      String? euteticPlateNumber,
      String? euteticPlateStatus,
      String? interiorInstallationStatus,
      String? gasStatus,
      String? extraNotes,
      String? currentUserID}) {
    final json = <String, dynamic>{
      "case_brand": caseBrand,
      "case_model": caseModel,
      "rear_door": rearDoor,
      "serial_number": serialNumber,
      "vehicle_information": vehicleInformation,
      "compressor_brand": compressorBrand,
      "compressor_model": compressorModel,
      "compressor_status": compressorStatus,
      "eutetic_plate_model": euteticPlateModel,
      "eutetic_plate_measurement": euteticPlateMeasurement,
      "eutetic_plate_number": euteticPlateNumber,
      "eutetic_plate_status": euteticPlateStatus,
      "interior_installation_status": interiorInstallationStatus,
      "gas_status": gasStatus,
      "extra_notes": extraNotes,
    };
    db.addDocumentToCollection(
        path: "/users/$currentUserID/refrigerations", json: json);
  }
}
