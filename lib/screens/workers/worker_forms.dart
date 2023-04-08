import 'package:atc_international/data/viewmodel/worker_vm.dart';
import 'package:atc_international/local_components/colors.dart';
import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:atc_international/local_components/fab.dart';
import 'package:flutter/material.dart';

class WorkerForms extends StatelessWidget {
  const WorkerForms({super.key});

  @override
  Widget build(BuildContext context) {
    String id;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      //if arguments equals to something(it's id in that example), it means that, worker forms page navigated from Admin account.

      id = ModalRoute.of(context)!.settings.arguments as String;
    } else {
      //if arguments equals to null, it means that, worker forms page Navigated from nowhere. It happens when service workers navigate this page

      id =
          "current_user_id"; //id is that string because I can't call future funtion getUserName here. I will take care of that gettin user ID part in .getJobForms() method. I send this string to do comprasion at conditional expressions
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("İŞ TAKİP FORMLARI"),
        ),
        floatingActionButton:
            const ProjectFAB(text: "Yeni Form Ekle", route: "/addNewForm"),
        body: FutureBuilder(
          future: WorkerViewModel().getJobForms(id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List? forms = snapshot.data;
              return ListView.builder(
                itemCount: forms!.length,
                itemBuilder: (context, index) {
                  return jobFormListTile(
                    customerName: forms[index]["customer"],
                    workerName: forms[index]["worker"],
                    date: forms[index]["finish_date"],
                    form: forms[index],
                  );
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ));
  }
}

class jobFormListTile extends StatelessWidget {
  String customerName;
  String workerName;
  String date;
  Map<String, dynamic> form;
  jobFormListTile(
      {super.key,
      required this.customerName,
      required this.workerName,
      required this.date,
      required this.form});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, "/customJobForm", arguments: form);
      },
      leading: const Icon(
        Icons.checklist_rounded,
        color: ProjectColor.darkBlue,
      ),
      title: Text(
        "İŞ TAKİP FORMU",
        textAlign: TextAlign.center,
        style: ProjectTextStyle.darkBlueSmallStrong(context),
      ),
      subtitle: Text(
        "$customerName - $workerName - $date",
        textAlign: TextAlign.center,
        style: ProjectTextStyle.lightBlueSmall(context),
      ),
      trailing: const Icon(
        Icons.arrow_right_sharp,
        size: 32,
        color: ProjectColor.red,
      ),
    );
  }
}
