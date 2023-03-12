import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:flutter/material.dart';
import '../../data/viewmodel/agenda_vm.dart';

class CompletedTasksPage extends StatefulWidget {
  const CompletedTasksPage({super.key});

  @override
  State<CompletedTasksPage> createState() => _CompletedTasksPageState();
}

class _CompletedTasksPageState extends State<CompletedTasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TAMAMLANMIŞ GÖREVLER"),
      ),
      body: FutureBuilder(
          future: AgendaModelView().getTasks(isCompleted: true),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return expansionTileListBuild(snapshot);
            } else {
              return const CircularProgressIndicator();
            }
          }),
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
            children: [
              Text(
                "Tamamlanma Tarihi ",
                style: ProjectTextStyle.redSmallStrong(context),
              ),
              Text(
                snapshot.data[index].taskCompleted,
                style: ProjectTextStyle.lightBlueSmallStrong(context),
              ),
            ],
          ),
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
