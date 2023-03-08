import 'package:atc_international/local_components/colors.dart';
import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:atc_international/local_components/fab.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../data/modelview/agenda_mw.dart';

class AgendaPage extends StatelessWidget {
  const AgendaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AJANDA"),
      ),
      body: Center(
          child: FutureBuilder(
              future: AgendaModelView().getCompletedTasks(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return expansionTileListBuild(snapshot);
                } else {
                  return CircularProgressIndicator();
                }
              })),
      floatingActionButton: ProjectFAB(text: "YENİ GÖREV"),
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
          SizedBox(height: 30),
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
          SizedBox(height: 30),
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
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.done_sharp,
                  color: Colors.green,
                ),
                iconSize: 48,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
                  color: ProjectColor.darkBlue,
                ),
                iconSize: 48,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                iconSize: 48,
              )
            ],
          )
        ],
      ),
    );
  }
}
