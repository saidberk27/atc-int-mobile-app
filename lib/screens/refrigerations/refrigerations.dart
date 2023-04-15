import 'package:atc_international/data/viewmodel/refrigeration_vm.dart';
import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:atc_international/local_components/drawer.dart';
import 'package:atc_international/local_components/fab.dart';
import 'package:atc_international/local_components/nav_bar.dart';
import 'package:atc_international/screens/refrigerations/refrigeration.dart';
import 'package:flutter/material.dart';

class Refrigerations extends StatelessWidget {
  const Refrigerations({super.key});

  @override
  Widget build(BuildContext context) {
    String imageData = "assets/images/ice-bucket.png";
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 1100) {
        return webScaffold(imageData);
      } else {
        return mobileScaffold(imageData);
      }
    });
  }

  Scaffold webScaffold(String imageData) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("KASALARIM"),
        ),
        floatingActionButton: Wrap(children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: const ProjectFAB(
              text: "FORM İLE YENİ KASA EKLE",
              route: "/addNewRefrigeration",
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: const ProjectFAB(
              text: "QR CODE İLE YENİ KASA EKLE",
              route: "/addNewRefrigerationQR",
            ),
          ),
        ]),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder(
                future: RefrigerationViewModel().getRefrigerations(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Row(
                      children: [
                        const ProjectSideNavMenu(),
                        Expanded(
                            flex: 8, child: buildCases(snapshot, imageData)),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                })));
  }

  Scaffold mobileScaffold(String imageData) {
    return Scaffold(
        drawer: const ProjectDrawer(),
        appBar: AppBar(
          title: const Text("KASALARIM"),
        ),
        floatingActionButton: Wrap(children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: const ProjectFAB(
              text: "FORM İLE YENİ KASA EKLE",
              route: "/addNewRefrigeration",
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: const ProjectFAB(
              text: "QR CODE İLE YENİ KASA EKLE",
              route: "/addNewRefrigerationQR",
            ),
          ),
        ]),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder(
                future: RefrigerationViewModel().getRefrigerations(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return buildCases(snapshot, imageData);
                  } else {
                    return const CircularProgressIndicator();
                  }
                })));
  }

  ListView buildCases(AsyncSnapshot<dynamic> snapshot, String imageData) {
    return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int index) {
          var data = snapshot.data[index];
          return refrigerationCard(imageData, context,
              caseBrand: data.caseBrand,
              caseModel: data.caseModel,
              rearDoor: data.rearDoor,
              serialNumber: data.serialNumber,
              vehicleInformation: data.vehicleInformation,
              compressorBrand: data.compressorBrand,
              compressorModel: data.compressorModel,
              compressorStatus: data.compressorStatus,
              euteticPlateModel: data.euteticPlateModel,
              euteticPlateMeasurement: data.euteticPlateMeasurement,
              euteticPlateNumber: data.euteticPlateNumber,
              euteticPlateStatus: data.euteticPlateStatus,
              interiorInstallationStatus: data.interiorInstallationStatus,
              gasStatus: data.gasStatus,
              extraNotes: data.extraNotes,
              id: data.id);
        });
  }

  Padding refrigerationCard(
    String imageData,
    BuildContext context, {
    required String caseBrand,
    required String caseModel,
    required String rearDoor,
    required String serialNumber,
    required String vehicleInformation,
    required String compressorBrand,
    required String compressorModel,
    required String compressorStatus,
    required String euteticPlateModel,
    required String euteticPlateMeasurement,
    required String euteticPlateNumber,
    required String euteticPlateStatus,
    required String interiorInstallationStatus,
    required String gasStatus,
    required String extraNotes,
    required String id,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, "/refrigeration",
            arguments: ScreenArguments(
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
                id: id)),
        child: Card(
          elevation: 4,
          child: Column(children: [
            Image.asset(imageData),
            Text(
              caseBrand,
              style: ProjectTextStyle.darkMediumStrong(context),
            ),
            Text(
              caseModel,
              style: ProjectTextStyle.darkMedium(context),
            ),
            const Icon(
              Icons.play_arrow,
              size: 36,
            )
          ]),
        ),
      ),
    );
  }
}
