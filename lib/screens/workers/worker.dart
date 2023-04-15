import 'package:atc_international/data/viewmodel/worker_vm.dart';
import 'package:atc_international/local_components/colors.dart';
import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:atc_international/local_components/nav_bar.dart';
import 'package:atc_international/local_components/shorten_string.dart';
import 'package:flutter/material.dart';

import '../../data/viewmodel/message_vm.dart';
import '../../local_components/profile_picture.dart';
import '../messages/custom_chat.dart';

class WorkerPage extends StatefulWidget {
  const WorkerPage({super.key, String? workerName});

  @override
  State<WorkerPage> createState() => _WorkerPageState();
}

class _WorkerPageState extends State<WorkerPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1100) {
          return webScaffold(context, args);
        } else {
          return mobileScaffold(context, args);
        }
      },
    );
  }

  Widget mobileScaffold(BuildContext context, ScreenArguments args) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          userTitle(context,
              workerName: args.workerName, workerCompany: args.workerCompany),
          const Divider(
            thickness: 2,
            color: ProjectColor.red,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                chatBubbleRow(context,
                    workerName: args.workerName, workerID: args.workerID),
                normalRow(context, "Çalıştığı Şirket: ", args.workerCompany),
                normalRow(context, "Unvan: ", args.workerTitle),
                normalRow(context, "E-Posta: ", args.workerMail),
                normalRow(context, "Telefon: ", args.workerPhone),
                showFormsListTile(context, workerID: args.workerID)
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
                onPressed: () {
                  deleteWorker(context, id: args.workerID);
                },
                child: const Text("Servis Elemanını Sil")),
          )
        ],
      ),
    );
  }

  Material showFormsListTile(BuildContext context, {required String workerID}) {
    return Material(
      elevation: 5,
      child: ListTile(
        title: Text(
          "Formları Görüntüle",
          style: ProjectTextStyle.darkBlueSmallStrong(context),
        ),
        onTap: () {
          Navigator.of(context).pushNamed("/workerForms", arguments: workerID);
        },
        trailing: const Icon(
          Icons.arrow_right,
          color: ProjectColor.darkBlue,
        ),
        leading: const Icon(
          Icons.checklist,
          color: ProjectColor.darkBlue,
        ),
        tileColor: Colors.white,
      ),
    );
  }

  Widget webScaffold(BuildContext context, ScreenArguments args) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        children: [
          const ProjectSideNavMenu(),
          Expanded(
            flex: 8,
            child: Column(
              children: [
                userTitle(context,
                    workerName: args.workerName,
                    workerCompany: args.workerCompany),
                const Divider(
                  thickness: 2,
                  color: ProjectColor.red,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      chatBubbleRow(context,
                          workerName: args.workerName, workerID: args.workerID),
                      normalRow(
                          context, "Çalıştığı Şirket: ", args.workerCompany),
                      normalRow(context, "Unvan: ", args.workerTitle),
                      normalRow(context, "E-Posta: ", args.workerMail),
                      normalRow(context, "Telefon: ", args.workerPhone),
                      showFormsListTile(context, workerID: args.workerID)
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                      onPressed: () {
                        deleteWorker(context, id: args.workerID);
                      },
                      child: const Text("Servis Elemanını Sil")),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  SizedBox chatBubbleRow(BuildContext context,
      {required String workerName, required String workerID}) {
    SnackBar snackBar =
        const SnackBar(content: Text("Mesaj Kutusu Açılıyor..."));

    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Text(
            "İsim Soyisim: ",
            style: ProjectTextStyle.redSmallStrong(context),
          ),
          Text(
            workerName,
            style: ProjectTextStyle.lightBlueSmallStrong(context),
          ),
          const Spacer(),
          IconButton(
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              MessageViewModel messageVM = MessageViewModel();
              String? chatID = await messageVM.getChatID(userID: workerID);

              Navigator.of(context).pushNamed(
                "/customChat",
                arguments: ChatScreenArguments(
                    chatPairName: workerName, chatID: chatID),
              );

              setState(() {});
            },
            icon: const Icon(Icons.chat_bubble),
            color: ProjectColor.red,
          )
        ],
      ),
    );
  }

  SizedBox normalRow(BuildContext context, String baslik, String icerik) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Text(
            baslik,
            style: ProjectTextStyle.redSmallStrong(context),
          ),
          Text(
            icerik,
            style: ProjectTextStyle.lightBlueSmallStrong(context),
          ),
        ],
      ),
    );
  }

  Row userTitle(BuildContext context,
      {required String workerName, required String workerCompany}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ProfilePicture(radius: 60),
        Column(
          children: [
            Text(
              shortenString(string: workerName, maxLength: 14),
              style: ProjectTextStyle.lightBlueBigStrong(context),
            ),
            Text(
              workerCompany,
              style: ProjectTextStyle.redMediumStrong(context),
            ),
          ],
        )
      ],
    );
  }

  void deleteWorker(context, {required String id}) {
    WorkerViewModel().deleteWorker(id: id);
    Navigator.of(context).pushNamed("/workers");
  }
}

class ScreenArguments {
  final String workerName;
  final String workerCompany;
  final String workerTitle;
  final String workerMail;
  final String workerPhone;
  final String workerID;

  ScreenArguments(
      {required this.workerMail,
      required this.workerName,
      required this.workerCompany,
      required this.workerPhone,
      required this.workerTitle,
      required this.workerID});
}
