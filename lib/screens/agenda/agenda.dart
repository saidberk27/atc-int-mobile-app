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
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              child: Text(snapshot.data[index].taskName));
                        });
                  } else {
                    return CircularProgressIndicator();
                  }
                })));
  }
}
