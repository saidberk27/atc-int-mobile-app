import 'package:atc_international/data/viewmodel/worker_vm.dart';
import 'package:atc_international/local_components/colors.dart';
import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:atc_international/local_components/nav_bar.dart';
import 'package:flutter/material.dart';

class CustomJobFormPage extends StatelessWidget {
  const CustomJobFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    print(arguments);
    Map coldenUnitMap = arguments["colden_unit"];
    Map allPanelsMap = arguments["all_panels"];
    Map fridgeInteriorMap = arguments["fridge_interior"];
    Map honeyCombsMap = arguments["honey_combs"];
    Map rearDoorMap = arguments["rear_door"];

    List<Widget> coldenGenerealUnitItems = [
      checkBoxRow(context, "Soğutma Genel Kontrol",
          coldenUnitMap["coldenGeneralControl"]),
      checkBoxRow(context, "Kompresör", coldenUnitMap["compressor"]),
      checkBoxRow(context, "Gaz Kontrol", coldenUnitMap["condensator"]),
      checkBoxRow(context, "Kondansatör", coldenUnitMap["gasControl"]),
    ];
    List<Widget> honeyCombsItems = [
      checkBoxRow(
          context, "Gaz Kaçağı Kontrolü", honeyCombsMap["gasLeakControl"]),
      checkBoxRow(
          context, "Petek Arıza ve Pas Kontrolü", honeyCombsMap["honeyComb"]),
      checkBoxRow(
          context, "Bağlantı Kontrolleri", honeyCombsMap["connectionControls"]),
      checkBoxRow(context, "Tüm Bağlantı Boruları Kontrol",
          honeyCombsMap["allConnectionPipesControls"]),
    ];
    List<Widget> allPanelsItems = [
      checkBoxRow(context, "Yan Panellerin Durumu", allPanelsMap["sidePanels"]),
      checkBoxRow(context, "Ön Panel Durumu", allPanelsMap["frontPanel"]),
      checkBoxRow(context, "Zemin Panel Durumu", allPanelsMap["floorPanel"]),
      checkBoxRow(
          context, "Zemin Drenaj Kontrolü", allPanelsMap["floorDrenage"]),
      checkBoxRow(context, "Panel Petek Bağlantı Kontrolü",
          allPanelsMap["panelHoneycombConnectionStatus"]),
      checkBoxRow(context, "Kasa Izalasyon Kontrolü",
          allPanelsMap["fridgeIsolationStatus"]),
      checkBoxRow(context, "Kasa İç-Dış Elektrik Kontrolü",
          allPanelsMap["fridgeDoorConnectionControl"]),
      checkBoxRow(context, "Kasa Kapı Bağlantı Kontrolü",
          allPanelsMap["fridgeDoorConnectionControl"]),
      checkBoxRow(context, "Kasa Bağlantı Vidaları Kontrolü",
          allPanelsMap["fridgeConnectionScrewControl"]),
    ];
    List<Widget> rearDoorItems = [
      checkBoxRow(
          context, "Kapı İzalasyon Durumu", rearDoorMap["doorIsolationStatus"]),
      checkBoxRow(context, "Kapı Lastikleri", rearDoorMap["doorPlastic"]),
      checkBoxRow(context, "Kilitler", rearDoorMap["locks"]),
      checkBoxRow(context, "Arka Kapı Çerçeve Durumu",
          rearDoorMap["rearDoorFrameStatus"]),
      checkBoxRow(
          context, "Arka Kapı Destekleri", rearDoorMap["rearDoorStands"]),
    ];
    List<Widget> fridgeInteriorItems = [
      checkBoxRow(context, "Zemin", fridgeInteriorMap["floor"]),
      checkBoxRow(context, "Petekler", fridgeInteriorMap["honeycombs"]),
      checkBoxRow(context, "Borular", fridgeInteriorMap["pipes"]),
      checkBoxRow(context, "İç Bölme ve Seperatörler",
          fridgeInteriorMap["innerSeperations"]),
      checkBoxRow(context, "Lambalar", fridgeInteriorMap["lights"]),
      checkBoxRow(
          context, "Çatı ve Diğer Ekler", fridgeInteriorMap["roofAndOthers"]),
    ];
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 1100) {
        return webScaffold(
            arguments,
            context,
            coldenGenerealUnitItems,
            honeyCombsItems,
            allPanelsItems,
            rearDoorItems,
            fridgeInteriorItems);
      } else {
        return mobileScaffold(
            arguments,
            context,
            coldenGenerealUnitItems,
            honeyCombsItems,
            allPanelsItems,
            rearDoorItems,
            fridgeInteriorItems);
      }
    });
  }

  Scaffold webScaffold(
      Map<String, dynamic> arguments,
      BuildContext context,
      List<Widget> coldenGenerealUnitItems,
      List<Widget> honeyCombsItems,
      List<Widget> allPanelsItems,
      List<Widget> rearDoorItems,
      List<Widget> fridgeInteriorItems) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("İş Takip Formu"),
      ),
      body: Row(
        children: [
          const ProjectSideNavMenu(),
          Expanded(
            flex: 8,
            child: scaffoldBody(
                arguments,
                context,
                coldenGenerealUnitItems,
                honeyCombsItems,
                allPanelsItems,
                rearDoorItems,
                fridgeInteriorItems),
          ),
        ],
      ),
    );
  }

  Scaffold mobileScaffold(
      Map<String, dynamic> arguments,
      BuildContext context,
      List<Widget> coldenGenerealUnitItems,
      List<Widget> honeyCombsItems,
      List<Widget> allPanelsItems,
      List<Widget> rearDoorItems,
      List<Widget> fridgeInteriorItems) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("İş Takip Formu"),
      ),
      body: scaffoldBody(arguments, context, coldenGenerealUnitItems,
          honeyCombsItems, allPanelsItems, rearDoorItems, fridgeInteriorItems),
    );
  }

  Padding scaffoldBody(
      Map<String, dynamic> arguments,
      BuildContext context,
      List<Widget> coldenGenerealUnitItems,
      List<Widget> honeyCombsItems,
      List<Widget> allPanelsItems,
      List<Widget> rearDoorItems,
      List<Widget> fridgeInteriorItems) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            singleRowInformationSection(
              title: "Müşteri:",
              content: arguments["customer"],
            ),
            const Divider(
              color: ProjectColor.darkGray,
              height: 40,
            ),
            singleRowInformationSection(
              title: "Tarih:",
              content: arguments["finish_date"],
            ),
            const Divider(
              color: ProjectColor.darkGray,
              height: 40,
            ),
            singleRowInformationSection(
              title: "Kasa No:",
              content: arguments["fridge_no"],
            ),
            const Divider(
              color: ProjectColor.darkGray,
              height: 40,
            ),
            singleRowInformationSection(
              title: "Araç Plaka ve Bilgisi:",
              content: arguments["vehicle_plate_and_info"],
            ),
            const Divider(
              color: ProjectColor.darkGray,
              height: 40,
            ),
            singleRowInformationSection(
              title: "Servis Personel İsmi:",
              content:
                  arguments["worker"], //TODO Servis ismini veritabanina ekle
            ),
            const Divider(
              color: ProjectColor.darkGray,
              height: 40,
            ),
            singleRowInformationSection(
              title: "Varış Saati",
              content: arguments["arrival_time"],
            ),
            const Divider(
              color: ProjectColor.darkGray,
              height: 40,
            ),
            singleRowInformationSection(
              title: "Ayrılış Saati",
              content: arguments["leave_time"],
            ),
            const Divider(
              color: ProjectColor.darkGray,
              height: 40,
            ),
            singleRowInformationSection(
              title: "Servis Yeri:",
              content: arguments["service_location"], //TODO servis yeri eksik
            ),
            const Divider(
              color: ProjectColor.darkGray,
              height: 10,
            ),
            expandableSection(context,
                title: "Soğutma Ünitesi", items: coldenGenerealUnitItems),
            const Divider(
              color: ProjectColor.darkGray,
              height: 10,
            ),
            expandableSection(context,
                title: "Petekler", items: honeyCombsItems),
            const Divider(
              color: ProjectColor.darkGray,
              height: 10,
            ),
            expandableSection(context,
                title: "Tüm Paneller", items: allPanelsItems),
            const Divider(
              color: ProjectColor.darkGray,
              height: 10,
            ),
            expandableSection(context,
                title: "Arka Kapı", items: rearDoorItems),
            const Divider(
              color: ProjectColor.darkGray,
              height: 10,
            ),
            expandableSection(context,
                title: "Kasa İç Aksamlar", items: fridgeInteriorItems),
            const Divider(
              color: ProjectColor.darkGray,
              height: 10,
            ),
            singleRowInformationSection(
              title: "Değişmesi Gereken Parçalar:",
              content: arguments["parts_must_change"],
            ),
            const Divider(
              color: ProjectColor.darkGray,
              height: 40,
            ),
            singleRowInformationSection(
              title: "Araç Ömür Durumu:",
              content: arguments["vehicle_health_status"],
            ),
            const Divider(
              color: ProjectColor.darkGray,
              height: 40,
            ),
            singleRowInformationSection(
              title: "Kasa İle İlgili Servis Dışı Yorumlar:",
              content: arguments["other_comments"],
            ),
            const Divider(
              color: ProjectColor.darkGray,
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const SizedBox(
                    height: 75, child: Center(child: Text("ANA MENÜYE DÖN"))))
          ],
        ),
      ),
    );
  }

  ExpansionTile expandableSection(BuildContext context,
      {required String title, required List<Widget> items}) {
    return ExpansionTile(
      collapsedTextColor: ProjectColor.darkBlue,
      collapsedIconColor: ProjectColor.darkBlue,
      textColor: ProjectColor.red,
      iconColor: ProjectColor.red,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      children: [
        Padding(
            padding: const EdgeInsets.all(18), child: Column(children: items))
      ],
    );
  }

  Row checkBoxRow(BuildContext context, String content, bool isChecked) {
    if (isChecked) {
      return Row(
        children: [
          Expanded(
            child: Text(
              content,
              style: ProjectTextStyle.darkBlueSmallStrong(context),
            ),
          ),
          Expanded(
            child: Icon(
              Icons.check_box,
              color: Colors.green[600],
            ),
          )
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Text(
              content,
              style: ProjectTextStyle.darkBlueSmallStrong(context),
            ),
          ),
          const Expanded(
            child: Icon(
              Icons.check_box_outline_blank,
              color: Colors.blueGrey,
            ),
          )
        ],
      );
    }
  }
}

class singleRowInformationSection extends StatelessWidget {
  String title;
  String content;
  singleRowInformationSection(
      {super.key, required String this.title, required String this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            title,
            style: ProjectTextStyle.redSmallStrong(context),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            content,
            style: ProjectTextStyle.darkBlueSmallStrong(context),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
