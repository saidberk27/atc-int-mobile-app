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
        floatingActionButton: const ProjectFAB(
          text: "YENİ KASA",
          route: "/addNewRefrigeration",
        ),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder(
                future: RefrigerationViewModel().getRefrigerations(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Row(
                      children: [
                        ProjectSideNavMenu(),
                        Expanded(
                            flex: 8, child: buildCases(snapshot, imageData)),
                      ],
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                })));
  }

  Scaffold mobileScaffold(String imageData) {
    return Scaffold(
        drawer: const ProjectDrawer(),
        appBar: AppBar(
          title: const Text("KASALARIM"),
        ),
        floatingActionButton: const ProjectFAB(
          text: "YENİ KASA",
          route: "/addNewRefrigeration",
        ),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder(
                future: RefrigerationViewModel().getRefrigerations(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return buildCases(snapshot, imageData);
                  } else {
                    return CircularProgressIndicator();
                  }
                })));
  }

  ListView buildCases(AsyncSnapshot<dynamic> snapshot, String imageData) {
    return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int index) {
          var data = snapshot.data[index];
          return refrigerationCard(imageData, context,
              caseName: data.caseName,
              caseModel: data.caseModel,
              outerMeasurement: data.outerMeasurement,
              innerMeasurement: data.innerMeasurement,
              vehicleChassisModel: data.vehicleChassisModel,
              workingTemperature: data.workingTemperature,
              coldenUnit: data.coldenUnit,
              eutaticPlates: data.eutaticPlates,
              dailyDoor: data.dailyDoor,
              dealTime: data.dealTime,
              innerTemperatureDuration: data.innerTemperatureDuration,
              caseWeight: data.caseWeight,
              innerVolume: data.innerVolume,
              weightCapacity: data.weightCapacity,
              id: data.id);
        });
  }

  Padding refrigerationCard(
    String imageData,
    BuildContext context, {
    required String caseName,
    required String caseModel,
    required String outerMeasurement,
    required String innerMeasurement,
    required String vehicleChassisModel,
    required String workingTemperature,
    required String coldenUnit,
    required String eutaticPlates,
    required String dailyDoor,
    required String dealTime,
    required String innerTemperatureDuration,
    required String caseWeight,
    required String innerVolume,
    required String weightCapacity,
    required String id,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, "/refrigeration",
            arguments: ScreenArguments(
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
                weightCapacity: weightCapacity,
                id: id)),
        child: Card(
          elevation: 4,
          child: Column(children: [
            Image.asset(imageData),
            Text(
              caseName,
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
