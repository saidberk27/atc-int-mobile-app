import 'package:atc_international/data/viewmodel/worker_vm.dart';
import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:atc_international/screens/workers/worker.dart';

import 'package:flutter/material.dart';
import 'package:atc_international/local_components/profile_picture.dart';

import '../../data/viewmodel/message_vm.dart';
import '../../local_components/drawer.dart';
import '../../local_components/fab.dart';
import '../../local_components/nav_bar.dart';
import '../messages/custom_chat.dart';

class WorkersPage extends StatefulWidget {
  const WorkersPage({super.key});

  @override
  State<WorkersPage> createState() => _WorkersPageState();
}

class _WorkersPageState extends State<WorkersPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  final String _pageTitle = "SERVİS ELEMANLARI";

  @override
  Widget build(BuildContext context) {
    const fabtext = "Yeni Servis Elemanı";
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1000) {
          return webScaffold(fabtext, _pageTitle);
        } else {
          return mobileScaffold(fabtext, _pageTitle);
        }
      },
    );
  }
}

Scaffold webScaffold(String fabtext, String pageTitle) {
  return Scaffold(
    body: Row(
      children: [
        const ProjectSideNavMenu(),
        Expanded(
          flex: 8,
          child: FutureBuilder(
            future: WorkerViewModel().getWorkers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return workerCard(context,
                        workerName: snapshot.data![index].workerName,
                        workerCompany: "ATC International",
                        workerTitle: snapshot.data![index].workerTitle,
                        workerMail: snapshot.data![index].workerMail,
                        workerPhone: snapshot.data![index].workerPhone,
                        workerID: snapshot.data![index].id);
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ],
    ),
    appBar: AppBar(title: Text(pageTitle)),
    floatingActionButton: ProjectFAB(
      text: fabtext,
      route: "/addNewWorker",
    ),
  );
}

Scaffold mobileScaffold(String fabtext, String pageTitle) {
  return Scaffold(
    body: FutureBuilder(
      future: WorkerViewModel().getWorkers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (BuildContext context, int index) {
              return workerCard(context,
                  workerName: snapshot.data![index].workerName,
                  workerCompany: "ATC International",
                  workerTitle: snapshot.data![index].workerTitle,
                  workerMail: snapshot.data![index].workerMail,
                  workerPhone: snapshot.data![index].workerPhone,
                  workerID: snapshot.data![index].id);
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    ),
    drawer: const ProjectDrawer(),
    appBar: AppBar(title: Text(pageTitle)),
    floatingActionButton: ProjectFAB(
      text: fabtext,
      route: "/addNewWorker",
    ),
  );
}

Card workerCard(BuildContext context,
    {required String workerName,
    required String workerCompany,
    required String workerTitle,
    required String workerPhone,
    required String workerMail,
    required String workerID}) {
  SnackBar snackBar = const SnackBar(content: Text("Mesaj Kutusu Açılıyor..."));
  return Card(
    elevation: 2,
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ProfilePicture(radius: 30),
          Column(
            children: [
              Text(
                workerName, //TODO take care of possible long names
                style: ProjectTextStyle.redMediumStrong(context),
              ),
              Text(
                workerCompany,
                style: ProjectTextStyle.lightBlueSmallStrong(context),
              )
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    MessageViewModel messageVM = MessageViewModel();
                    String? chatID =
                        await messageVM.getChatID(userID: workerID);

                    Navigator.of(context).pushNamed("/customChat",
                        arguments: ChatScreenArguments(
                            chatPairName: workerName, chatID: chatID));
                  },
                  icon: const Icon(Icons.chat_bubble)),
              IconButton(
                  onPressed: () => Navigator.pushNamed(context, "/worker",
                      arguments: ScreenArguments(
                          workerName: workerName,
                          workerCompany: workerCompany,
                          workerMail: workerMail,
                          workerPhone: workerPhone,
                          workerTitle: workerTitle,
                          workerID: workerID)),
                  icon: const Icon(Icons.info_outlined))
            ],
          )
        ],
      ),
    ),
  );
}
