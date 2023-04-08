import 'package:atc_international/data/viewmodel/worker_vm.dart';
import 'package:atc_international/local_components/colors.dart';
import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:atc_international/local_components/drawer.dart';
import 'package:atc_international/local_components/fab.dart';
import 'package:flutter/material.dart';

class WorkerForms extends StatelessWidget {
  const WorkerForms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("İŞ TAKİP FORMLARI"),
        ),
        drawer: const ProjectDrawer(),
        floatingActionButton:
            const ProjectFAB(text: "Yeni Form Ekle", route: "/addNewForm"),
        body: FutureBuilder(
          future: WorkerViewModel().getJobForms(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List? forms = snapshot.data;
              return ListView.builder(
                itemCount: forms!.length,
                itemBuilder: (context, index) {
                  return jobFormListTile(
                    customerName: forms[index]["customer"],
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
  Map<String, dynamic> form;
  jobFormListTile(
      {super.key,
      required String this.customerName,
      required Map<String, dynamic> this.form});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, "/customJobForm", arguments: form);
      },
      leading: const Icon(
        Icons.view_list,
        color: ProjectColor.darkBlue,
      ),
      title: Text(
        "İŞ TAKİP FORMU",
        textAlign: TextAlign.center,
        style: ProjectTextStyle.darkBlueSmallStrong(context),
      ),
      subtitle: Text(
        customerName,
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
