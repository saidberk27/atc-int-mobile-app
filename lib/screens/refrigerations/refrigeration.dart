import 'package:atc_international/data/viewmodel/refrigeration_vm.dart';
import 'package:atc_international/local_components/colors.dart';
import 'package:atc_international/local_components/nav_bar.dart';
import 'package:atc_international/local_components/shorten_string.dart';
import 'package:flutter/material.dart';

import '../../local_components/custom_text_themes.dart';

class Refrigeration extends StatelessWidget {
  const Refrigeration({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 1100) {
        return webScaffold(args, context);
      } else {
        return mobileScaffold(args, context);
      }
    });
  }

  Scaffold webScaffold(ScreenArguments args, BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(args.caseName!),
      ),
      body: Row(
        children: [
          ProjectSideNavMenu(),
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4, color: ProjectColor.darkBlue),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: Image.asset(
                        "assets/images/eutatic.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  normalRow(context, "Model: ", args.caseModel!),
                  normalRow(context, "Yan kapı sayısı: ", args.dailyDoor!),
                  normalRow(
                      context, "Dıştan dışa ölçüler: ", args.outerMeasurement!),
                  normalRow(
                      context, "Içten içe ölçüler: ", args.innerMeasurement!),
                  normalRow(context, "Araç Şasi modelleri: ",
                      args.vehicleChassisModel!),
                  normalRow(context, "Çalışma sıcaklık aralığı",
                      args.workingTemperature!),
                  normalRow(context, "Soğutma ünitesi: ", args.coldenUnit!),
                  normalRow(context, "Ötektik pleytler: ", args.eutaticPlates!),
                  normalRow(
                      context, "Günlük kapı açılma sayısı: ", args.dailyDoor!),
                  normalRow(context, "Dağıtım zamanı: ", args.dealTime!),
                  normalRow(context, "İç Isı değişim süresi: ",
                      args.innerTemperatureDuration!),
                  normalRow(context, "Kasa ağırlığı: ", args.caseWeight!),
                  normalRow(context, "İç hacim: ", args.innerVolume!),
                  normalRow(context, "Yük yükleme kapasitesi: ",
                      args.weightCapacity!),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: SizedBox(
                      height: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          RefrigerationViewModel()
                              .removeRefrigeration(id: args.id!);
                          SnackBar snackBar = const SnackBar(
                            content: Text("Kasa Siliniyor ..."),
                            duration: Duration(milliseconds: 500),
                          );

                          Navigator.of(context).pushNamed("/refrigerations");
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: const Text("Kasayı Sil"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Scaffold mobileScaffold(ScreenArguments args, BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(args.caseName!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 4, color: ProjectColor.darkBlue),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: Image.asset("assets/images/eutatic.png"),
            ),
            normalRow(context, "Model: ", args.caseModel!),
            normalRow(context, "Yan kapı sayısı: ", args.dailyDoor!),
            normalRow(context, "Dıştan dışa ölçüler: ", args.outerMeasurement!),
            normalRow(context, "Içten içe ölçüler: ", args.innerMeasurement!),
            normalRow(
                context, "Araç Şasi modelleri: ", args.vehicleChassisModel!),
            normalRow(
                context, "Çalışma sıcaklık aralığı", args.workingTemperature!),
            normalRow(context, "Soğutma ünitesi: ", args.coldenUnit!),
            normalRow(context, "Ötektik pleytler: ", args.eutaticPlates!),
            normalRow(context, "Günlük kapı açılma sayısı: ", args.dailyDoor!),
            normalRow(context, "Dağıtım zamanı: ", args.dealTime!),
            normalRow(context, "İç Isı değişim süresi: ",
                args.innerTemperatureDuration!),
            normalRow(context, "Kasa ağırlığı: ", args.caseWeight!),
            normalRow(context, "İç hacim: ", args.innerVolume!),
            normalRow(
                context, "Yük yükleme kapasitesi: ", args.weightCapacity!),
            Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton(
                onPressed: () {
                  RefrigerationViewModel().removeRefrigeration(id: args.id!);
                  SnackBar snackBar = const SnackBar(
                    content: Text("Kasa Siliniyor ..."),
                    duration: Duration(milliseconds: 500),
                  );

                  Navigator.of(context).pushNamed("/refrigerations");
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: const Text("Kasayı Sil"),
              ),
            )
          ],
        ),
      ),
    );
  }

  SizedBox normalRow(BuildContext context, String baslik, String icerik) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: Text(
              baslik,
              style: ProjectTextStyle.redSmallStrong(context),
            ),
          ),
          Expanded(
            child: Text(
              shortenString(string: icerik, maxLength: 34),
              style: ProjectTextStyle.lightBlueSmallStrong(context),
            ),
          ),
        ],
      ),
    );
  }
}

class ScreenArguments {
  String? caseName;
  String? caseModel;
  String? outerMeasurement;
  String? innerMeasurement;
  String? vehicleChassisModel;
  String? workingTemperature;
  String? coldenUnit;
  String? eutaticPlates;
  String? dailyDoor;
  String? dealTime;
  String? innerTemperatureDuration;
  String? caseWeight;
  String? innerVolume;
  String? weightCapacity;
  String? id;
  ScreenArguments(
      {required String this.caseName,
      required String this.caseModel,
      required String this.outerMeasurement,
      required String this.innerMeasurement,
      required String this.vehicleChassisModel,
      required String this.workingTemperature,
      required String this.coldenUnit,
      required String this.eutaticPlates,
      required String this.dailyDoor,
      required String this.dealTime,
      required String this.innerTemperatureDuration,
      required String this.caseWeight,
      required String this.innerVolume,
      required String this.weightCapacity,
      required String this.id});
}
