import 'package:atc_international/data/viewmodel/refrigeration_vm.dart';
import 'package:atc_international/local_components/colors.dart';
import 'package:atc_international/local_components/nav_bar.dart';
import 'package:atc_international/local_components/shorten_string.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
        title: Text(args.caseBrand!),
      ),
      body: Row(
        children: [
          const ProjectSideNavMenu(),
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
                  normalRow(context, "Kasa Markası: ", args.caseBrand!,
                      icon: Icons.abc),
                  normalRow(context, "Model: ", args.caseModel!,
                      icon: MdiIcons.fridgeIndustrial),
                  normalRow(context, "Seri Numarası: ", args.serialNumber!,
                      icon: MdiIcons.barcodeScan),
                  normalRow(
                      context, "Araç Bilgileri: ", args.vehicleInformation!,
                      icon: Icons.local_shipping),
                  normalRow(context, "Arka Kapı: ", args.rearDoor!,
                      icon: MdiIcons.doorSliding),
                  normalRow(
                      context, "Kompresör Markası: ", args.compressorBrand!,
                      icon: MdiIcons.airFilter),
                  normalRow(
                      context, "Kompresör Modeli: ", args.compressorModel!,
                      icon: MdiIcons.airFilter),
                  normalRow(
                      context, "Kompresör Durumu: ", args.compressorStatus!,
                      icon: MdiIcons.listStatus),
                  normalRow(
                      context, "Ötetik Plaka Modeli: ", args.euteticPlateModel!,
                      icon: MdiIcons.snowflakeThermometer),
                  normalRow(context, "Ötetik Plaka Ölçüleri: ",
                      args.euteticPlateMeasurement!,
                      icon: MdiIcons.rulerSquare),
                  normalRow(context, "Ötetik Plaka Sayısı: ",
                      args.euteticPlateNumber!,
                      icon: MdiIcons.counter),
                  normalRow(context, "Ötetik Plaka Durumu: ",
                      args.euteticPlateStatus!,
                      icon: MdiIcons.listStatus),
                  normalRow(context, "İç Tesisat Durumu: ",
                      args.interiorInstallationStatus!,
                      icon: MdiIcons.hammerWrench),
                  normalRow(context, "Gaz Durumu: ", args.gasStatus!,
                      icon: MdiIcons.gasCylinder),
                  normalRow(context, "Notlar: ", args.extraNotes!,
                      icon: MdiIcons.text),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        /*
                        SizedBox(
                          height: 150,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  "/addNewRefrigeration",
                                  arguments: ["update"]);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("Kasayı Düzenle"),
                                SizedBox(width: 10),
                                Icon(Icons.edit)
                              ],
                            ),
                          ),
                        ),*/
                        SizedBox(
                          height: 150,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  ProjectColor.red),
                              side:
                                  MaterialStateProperty.resolveWith<BorderSide>(
                                (Set<MaterialState> states) {
                                  return const BorderSide(
                                      color: Colors.red,
                                      width: 2); // varsayılan kenarlık rengi
                                },
                              ),
                            ),
                            onPressed: () {
                              RefrigerationViewModel()
                                  .removeRefrigeration(id: args.id!);
                              SnackBar snackBar = const SnackBar(
                                content: Text("Kasa Siliniyor ..."),
                                duration: Duration(milliseconds: 500),
                              );

                              Navigator.of(context)
                                  .pushNamed("/refrigerations");
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            child: Row(
                              children: const [
                                Text("Kasayı Sil"),
                                SizedBox(width: 10),
                                Icon(Icons.delete)
                              ],
                            ),
                          ),
                        ),
                      ],
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
        title: Text(args.caseBrand!),
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
            normalRow(context, "Kasa Markası: ", args.caseBrand!,
                icon: Icons.abc),
            normalRow(context, "Model: ", args.caseModel!,
                icon: MdiIcons.fridgeIndustrial),
            normalRow(context, "Seri Numarası: ", args.serialNumber!,
                icon: MdiIcons.barcodeScan),
            normalRow(context, "Araç Bilgileri: ", args.vehicleInformation!,
                icon: Icons.local_shipping),
            normalRow(context, "Arka Kapı: ", args.rearDoor!,
                icon: MdiIcons.doorSliding),
            normalRow(context, "Kompresör Markası: ", args.compressorBrand!,
                icon: MdiIcons.airFilter),
            normalRow(context, "Kompresör Modeli: ", args.compressorModel!,
                icon: MdiIcons.airFilter),
            normalRow(context, "Kompresör Durumu: ", args.compressorStatus!,
                icon: MdiIcons.listStatus),
            normalRow(context, "Ötetik Plaka Modeli: ", args.euteticPlateModel!,
                icon: MdiIcons.snowflakeThermometer),
            normalRow(context, "Ötetik Plaka Ölçüleri: ",
                args.euteticPlateMeasurement!,
                icon: MdiIcons.rulerSquare),
            normalRow(
                context, "Ötetik Plaka Sayısı: ", args.euteticPlateNumber!,
                icon: MdiIcons.counter),
            normalRow(
                context, "Ötetik Plaka Durumu: ", args.euteticPlateStatus!,
                icon: MdiIcons.listStatus),
            normalRow(context, "İç Tesisat Durumu: ",
                args.interiorInstallationStatus!,
                icon: MdiIcons.hammerWrench),
            normalRow(context, "Gaz Durumu: ", args.gasStatus!,
                icon: MdiIcons.gasCylinder),
            normalRow(context, "Notlar: ", args.extraNotes!,
                icon: MdiIcons.text),
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

  SizedBox normalRow(BuildContext context, String baslik, String icerik,
      {required IconData? icon}) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Icon(
                icon,
                color: ProjectColor.darkBlue,
              )),
          Expanded(
            flex: 6,
            child: Text(
              baslik,
              textAlign: TextAlign.center,
              style: ProjectTextStyle.redSmallStrong(context),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              shortenString(string: icerik, maxLength: 34),
              textAlign: TextAlign.center,
              style: ProjectTextStyle.lightBlueSmallStrong(context),
            ),
          ),
        ],
      ),
    );
  }
}

class ScreenArguments {
  String? caseBrand;
  String? caseModel;
  String? rearDoor;
  String? serialNumber;
  String? vehicleInformation;
  String? compressorBrand;
  String? compressorModel;
  String? compressorStatus;
  String? euteticPlateModel;
  String? euteticPlateMeasurement;
  String? euteticPlateNumber;
  String? euteticPlateStatus;
  String? interiorInstallationStatus;
  String? gasStatus;
  String? extraNotes;
  String? id;
  ScreenArguments(
      {required String this.caseBrand,
      required String this.caseModel,
      required String this.rearDoor,
      required String this.serialNumber,
      required String this.vehicleInformation,
      required String this.compressorBrand,
      required String this.compressorModel,
      required String this.compressorStatus,
      required String this.euteticPlateModel,
      required String this.euteticPlateMeasurement,
      required String this.euteticPlateNumber,
      required String this.euteticPlateStatus,
      required String this.interiorInstallationStatus,
      required String this.gasStatus,
      required String this.extraNotes,
      required String this.id});
}
