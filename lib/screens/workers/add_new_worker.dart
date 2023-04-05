import 'package:atc_international/data/viewmodel/worker_vm.dart';
import 'package:atc_international/local_components/nav_bar.dart';

import 'package:flutter/material.dart';

import '../../data/viewmodel/worker_vm.dart';

class AddNewWorker extends StatefulWidget {
  const AddNewWorker({super.key});

  @override
  State<AddNewWorker> createState() => _AddNewWorkerState();
}

class _AddNewWorkerState extends State<AddNewWorker> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _workerNameController.dispose();

    _workerTitleController.dispose();
    _workerMailController.dispose();
    _workerPhoneController.dispose();
    _workerPasswordController.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _workerNameController = TextEditingController();

  final TextEditingController _workerTitleController = TextEditingController();
  final TextEditingController _workerMailController = TextEditingController();
  final TextEditingController _workerPasswordController =
      TextEditingController();
  final TextEditingController _workerPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 1100) {
        return webScaffold();
      } else {
        return mobileScaffold();
      }
    });
  }

  Scaffold webScaffold() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yeni Servis Elemanı Ekle"),
      ),
      body: Row(
        children: [
          const ProjectSideNavMenu(),
          Expanded(
            flex: 8,
            child: Padding(
                padding: const EdgeInsets.only(top: 24, right: 12, left: 12),
                child: Form(
                    key: _formKey,
                    child: ListView(children: [
                      textFormField(
                          hintText: "Servis Elemanı İsmi",
                          controller: _workerNameController),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "Unvan",
                          controller: _workerTitleController,
                          icon: Icons.title),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "E-Posta",
                          controller: _workerMailController,
                          icon: Icons.email_outlined),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "Parola",
                          controller: _workerPasswordController,
                          icon: Icons.lock),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "Telefon",
                          controller: _workerPhoneController,
                          icon: Icons.phone_callback_outlined),
                      const SizedBox(height: 40),
                      elevatedButton(),
                      const SizedBox(height: 20),
                    ]))),
          ),
        ],
      ),
    );
  }

  Scaffold mobileScaffold() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yeni Servis Elemanı Ekle"),
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 24, right: 12, left: 12),
          child: Form(
              key: _formKey,
              child: ListView(children: [
                textFormField(
                    hintText: "Servis Elemanı İsmi",
                    controller: _workerNameController),
                const SizedBox(height: 40),
                textFormField(
                    hintText: "Unvan",
                    controller: _workerTitleController,
                    icon: Icons.title),
                const SizedBox(height: 40),
                textFormField(
                    hintText: "E-Posta",
                    controller: _workerMailController,
                    icon: Icons.email_outlined),
                const SizedBox(height: 40),
                textFormField(
                    hintText: "Parola",
                    controller: _workerPasswordController,
                    icon: Icons.lock),
                const SizedBox(height: 40),
                textFormField(
                    hintText: "Telefon",
                    controller: _workerPhoneController,
                    icon: Icons.phone_callback_outlined),
                const SizedBox(height: 40),
                elevatedButton(),
                const SizedBox(height: 20),
              ]))),
    );
  }

  TextFormField textFormField(
      {required String hintText,
      required TextEditingController controller,
      IconData? icon}) {
    icon == null ? icon = Icons.abc : icon = icon;

    return TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
          prefixIcon: Icon(icon),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return '$hintText Boş Olamaz';
          }
          return null;
        });
  }

  ElevatedButton elevatedButton() {
    return ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            saveAndNavigate();
          }
        },
        child: const SizedBox(
          height: 100,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "Yeni Eleman Ekle",
            ),
          ),
        ));
  }

  void saveAndNavigate() {
    WorkerViewModel workerVm = WorkerViewModel();
    const snackBar = SnackBar(content: Text('Kaydediliyor...'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    String workerName = _workerNameController.text;
    String workerTitle = _workerTitleController.text;
    String workerMail = _workerMailController.text;
    String workerPassword = _workerPasswordController.text;
    String workerPhone = _workerPhoneController.text;

    workerVm.saveWorker(
        workerName: workerName,
        workerTitle: workerTitle,
        workerCompany: "ATC International",
        workerMail: workerMail,
        workerPassword: workerPassword,
        workerPhone: workerPhone);

    Navigator.of(context).pushNamed("/workers");
  }
}
