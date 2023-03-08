import 'package:atc_international/local_components/colors.dart';
import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:atc_international/local_components/fab.dart';
import 'package:flutter/material.dart';
import '../../data/modelview/agenda_mw.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AJANDA"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 6,
            child: FutureBuilder(
                future: AgendaModelView().getCompletedTasks(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return expansionTileListBuild(snapshot);
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Tamamlanmış Görevleri Görüntüle",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: const ProjectFAB(
        text: "YENİ GÖREV",
        route: "/addNewTask",
      ),
    );
  }

  ListView expansionTileListBuild(AsyncSnapshot<dynamic> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int index) {
          return expansionTile(snapshot, index, context);
        });
  }

  ExpansionTile expansionTile(
      AsyncSnapshot<dynamic> snapshot, int index, BuildContext context) {
    return ExpansionTile(
        title: Text(
          snapshot.data[index].taskName,
          style: ProjectTextStyle.darkBlueMediumStrong(context),
        ),
        children: [
          tileContents(context, snapshot, index),
        ]);
  }

  Padding tileContents(
      BuildContext context, AsyncSnapshot<dynamic> snapshot, int index) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Görev Açıklaması: ",
                style: ProjectTextStyle.redSmallStrong(context),
              ),
              Expanded(
                child: Text(snapshot.data[index].taskDescription,
                    style: ProjectTextStyle.lightBlueSmallStrong(context)),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Text(
                "Eklendiği Tarih: ",
                style: ProjectTextStyle.redSmallStrong(context),
              ),
              Text(snapshot.data[index].taskAdded,
                  style: ProjectTextStyle.lightBlueSmallStrong(context)),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Text(
                "Sona Erme Tarihi: ",
                style: ProjectTextStyle.redSmallStrong(context),
              ),
              Text(
                snapshot.data[index].deadEnd,
                style: ProjectTextStyle.lightBlueSmallStrong(context),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.done_sharp,
                  color: Colors.green,
                ),
                iconSize: 48,
              ),
              IconButton(
                onPressed: () {
                  removeFromDatabase(snapshot, index);
                },
                icon: const Icon(
                  Icons.delete,
                  color: ProjectColor.red,
                ),
                iconSize: 48,
              )
            ],
          )
        ],
      ),
    );
  }

  void removeFromDatabase(AsyncSnapshot<dynamic> snapshot, int index) {
    return setState(() {
      print(snapshot.data[index].taskId);
      AgendaModelView().removeTaskFromDatabase(id: snapshot.data[index].taskId);
    });
  }
}
