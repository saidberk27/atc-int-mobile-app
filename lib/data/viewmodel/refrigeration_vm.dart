import '../model/project_firestore.dart';

class RefrigerationViewModel {
  ProjectFirestore db = ProjectFirestore();
  Future<List<dynamic>> getRefrigerations() async {
    List modelList = [];

    var refrigerations = await db.readDocumentsFromDatabase(
        collectionPath: "/refrigerations/refrigerations/refrigerations");

    for (int i = 0; i < refrigerations.length; i++) {
      modelList.add(Refrigeration.fromJson(json: refrigerations[i]));
    }
    return modelList;
  }

  Future<void> addRefrigeration(
      {required String caseName,
      required String caseModel,
      String? outerMeasurement,
      String? innerMeasurement,
      String? vehicleChassisModel,
      String? workingTemperature,
      String? coldenUnit,
      String? eutaticPlates,
      String? dailyDoor,
      String? dealTime,
      String? innerTemperatureDuration,
      String? caseWeight,
      String? innerVolume,
      String? weightCapacity}) async {
    print("view model");
    outerMeasurement == null
        ? outerMeasurement = "Belirtilmedi."
        : outerMeasurement = outerMeasurement;

    innerMeasurement == null
        ? outerMeasurement = "Belirtilmedi."
        : outerMeasurement = innerMeasurement;

    vehicleChassisModel == null
        ? vehicleChassisModel = "Belirtilmedi."
        : vehicleChassisModel = vehicleChassisModel;

    workingTemperature == null
        ? workingTemperature = "Belirtilmedi."
        : workingTemperature = workingTemperature;

    coldenUnit == null ? coldenUnit = "Belirtilmedi." : coldenUnit = coldenUnit;

    eutaticPlates == null
        ? eutaticPlates = "Belirtilmedi."
        : eutaticPlates = eutaticPlates;

    dailyDoor == null ? dailyDoor = "Belirtilmedi." : dailyDoor = dailyDoor;

    dealTime == null ? dealTime = "Belirtilmedi." : dealTime = dealTime;

    innerTemperatureDuration == null
        ? innerTemperatureDuration = "Belirtilmedi."
        : innerTemperatureDuration = innerTemperatureDuration;

    caseWeight == null ? caseWeight = "Belirtilmedi." : caseWeight = caseWeight;

    innerVolume == null
        ? innerVolume = "Belirtilmedi."
        : innerVolume = innerVolume;

    weightCapacity == null
        ? weightCapacity = "Belirtilmedi."
        : weightCapacity = weightCapacity;

    Refrigeration.toJson(
        caseName: caseName,
        caseModel: caseModel,
        outerMeasurement: outerMeasurement,
        innerMeasurement: innerMeasurement,
        vehicleChassisModel: vehicleChassisModel,
        workingTemperature: workingTemperature,
        coldenUnit: coldenUnit,
        eutaticPlates: eutaticPlates,
        dailyDoor: dailyDoor,
        dealTime: dealTime,
        innerTemperatureDuration: innerTemperatureDuration,
        caseWeight: caseWeight,
        innerVolume: innerVolume,
        weightCapacity: weightCapacity);
  }

  Future<void> removeRefrigeration({required String id}) async {
    db.removeFromDatabase(
        documentPath: "/refrigerations/refrigerations/refrigerations", id: id);
  }
}

class Refrigeration {
  ProjectFirestore db = ProjectFirestore();
  late final String caseName;
  late final String caseModel;
  late final String outerMeasurement;
  late final String innerMeasurement;
  late final String vehicleChassisModel;
  late final String workingTemperature;
  late final String coldenUnit;
  late final String eutaticPlates;
  late final String dailyDoor;
  late final String dealTime;
  late final String innerTemperatureDuration;
  late final String caseWeight;
  late final String innerVolume;
  late final String weightCapacity;
  late final String id;
  Refrigeration.fromJson({required Map json}) {
    caseName = json["case_name"];
    caseModel = json["case_model"];
    outerMeasurement = json["outer_measurement"];
    innerMeasurement = json["inner_measurement"];
    vehicleChassisModel = json["vehicle_chassis_model"];
    workingTemperature = json["working_temperature"];
    coldenUnit = json["colden_unit"];
    eutaticPlates = json["eutatic_plates"];
    dailyDoor = json["daily_door"];
    dealTime = json["deal_time"];
    innerTemperatureDuration = json["inner_temperature_duration"];
    caseWeight = json["case_weight"];
    innerVolume = json["inner_volume"];
    weightCapacity = json["weight_capacity"];
    id = json["id"];
  }

  Refrigeration.toJson(
      {String? caseName,
      String? caseModel,
      String? outerMeasurement,
      String? innerMeasurement,
      String? vehicleChassisModel,
      String? workingTemperature,
      String? coldenUnit,
      String? eutaticPlates,
      String? dailyDoor,
      String? dealTime,
      String? innerTemperatureDuration,
      String? caseWeight,
      String? innerVolume,
      String? weightCapacity}) {
    final json = <String, dynamic>{
      "case_name": caseName,
      "case_model": caseModel,
      "outer_measurement": outerMeasurement,
      "inner_measurement": innerMeasurement,
      "vehicle_chassis_model": vehicleChassisModel,
      "working_temperature": workingTemperature,
      "colden_unit": coldenUnit,
      "eutatic_plates": eutaticPlates,
      "daily_door": dailyDoor,
      "deal_time": dealTime,
      "inner_temperature_duration": innerTemperatureDuration,
      "case_weight": caseWeight,
      "inner_volume": innerVolume,
      "weight_capacity": weightCapacity
    };
    db.addDocumentToCollection(
        path: "/refrigerations/refrigerations/refrigerations", json: json);
  }
}
