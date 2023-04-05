import 'package:atc_international/local_components/drawer.dart';
import 'package:flutter/material.dart';

class WorkerForms extends StatefulWidget {
  const WorkerForms({super.key});

  @override
  State<WorkerForms> createState() => _WorkerFormsState();
}

class _WorkerFormsState extends State<WorkerForms> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    List<Step> formSteps = <Step>[
      Step(
          title: Text('Genel Bilgiler'),
          content: Form(
            child: TextFormField(),
          )),
      Step(
          title: Text('Genel Bilgiler'),
          content: Form(
            child: TextFormField(),
          )),
      const Step(
        title: Text('Tüm Paneller'),
        content: Text('Content for Step 2'),
      ),
      const Step(
        title: Text('Arka Kapı'),
        content: Text('Content for Step 2'),
      ),
      const Step(
        title: Text('Kasa İç Aksamlar'),
        content: Text('Content for Step 2'),
      ),
      const Step(
        title: Text('Değişmesi Gereken Parçalar'),
        content: Text('Content for Step 2'),
      ),
      const Step(
        title: Text('Kasa ile İlgili Servis Dışı Yorumlar'),
        content: Text('Content for Step 2'),
      ),
    ];
    return Scaffold(
        appBar: AppBar(
          title: const Text("İŞ TAKİP FORMLARIM"),
        ),
        drawer: const ProjectDrawer(),
        body: Stepper(
          currentStep: _index,
          onStepCancel: () {
            if (_index > 0) {
              setState(() {
                _index -= 1;
              });
            }
          },
          onStepContinue: () {
            if (_index < formSteps.length - 1) {
              setState(() {
                _index = _index + 1;
              });
            }
          },
          onStepTapped: (int index) {
            setState(() {
              _index = index;
            });
          },
          steps: formSteps,
        ));
  }
}
