import 'package:atc_international/local_components/colors.dart';
import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:atc_international/local_components/drawer.dart';
import 'package:atc_international/local_components/fab.dart';
import 'package:atc_international/local_components/nav_bar.dart';
import 'package:flutter/material.dart';
import '../../data/viewmodel/agenda_vm.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 1100) {
        return webScaffold(context);
      } else {
        return mobileScaffold(context);
      }
    });
  }

  Scaffold webScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AJANDA"),
      ),
      body: Row(
        children: [
          ProjectSideNavMenu(),
          Expanded(
            flex: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 6,
                  child: FutureBuilder(
                      future: AgendaModelView().getTasks(isCompleted: false),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return expansionTileListBuild(snapshot);
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(32.0, 12.0, 32.0, 76.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/completedTasks");
                      },
                      child: SizedBox(
                        height: 50,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Tamamlanmış Görevleri Görüntüle",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: const ProjectFAB(
        text: "YENİ GÖREV",
        route: "/addNewTask",
      ),
    );
  }

  Scaffold mobileScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AJANDA"),
      ),
      drawer: ProjectDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 6,
            child: FutureBuilder(
                future: AgendaModelView().getTasks(isCompleted: false),
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
                  onPressed: () {
                    Navigator.of(context).pushNamed("/completedTasks");
                  },
                  child: SizedBox(
                    height: 75,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Tamamlanmış Görevleri Görüntüle",
                        textAlign: TextAlign.center,
                      ),
                    ),
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
                onPressed: () {
                  setState(() {});
                  AgendaModelView()
                      .completeTask(id: snapshot.data[index].taskId);
                },
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
