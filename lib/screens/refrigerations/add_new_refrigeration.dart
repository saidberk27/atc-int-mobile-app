import 'package:atc_international/data/viewmodel/refrigeration_vm.dart';
import 'package:atc_international/local_components/nav_bar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';

class AddNewRefrigeration extends StatefulWidget {
  const AddNewRefrigeration({super.key});

  @override
  State<AddNewRefrigeration> createState() => _AddNewRefrigerationState();
}

class _AddNewRefrigerationState extends State<AddNewRefrigeration> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _caseBrandController.dispose();
    _caseModelController.dispose();
    _serialNumberController.dispose();
    _rearDoorController.dispose();
    _vehicleInformationController.dispose();
    _compressorBrandController.dispose();
    _compressorModelController.dispose();
    _compressorStatusController.dispose();
    _euteticPlateModelController.dispose();
    _euteticPlateMeasurementsController.dispose();
    _euteticPlateNumberController.dispose();
    _euteticPlateStatusController.dispose();
    _interiorInstallationStatusController.dispose();
    _gasStatusController.dispose();
    _extraNotesController.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _caseBrandController = TextEditingController();
  final TextEditingController _caseModelController = TextEditingController();

  final TextEditingController _serialNumberController = TextEditingController();
  final TextEditingController _rearDoorController = TextEditingController();
  final TextEditingController _vehicleInformationController =
      TextEditingController();
  final TextEditingController _compressorBrandController =
      TextEditingController();
  final TextEditingController _compressorModelController =
      TextEditingController();
  final TextEditingController _compressorStatusController =
      TextEditingController();
  final TextEditingController _euteticPlateModelController =
      TextEditingController();
  final TextEditingController _euteticPlateMeasurementsController =
      TextEditingController();
  final TextEditingController _euteticPlateStatusController =
      TextEditingController();
  final TextEditingController _interiorInstallationStatusController =
      TextEditingController();
  final TextEditingController _gasStatusController = TextEditingController();
  final TextEditingController _euteticPlateNumberController =
      TextEditingController();
  final TextEditingController _extraNotesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const pageTitle = "Yeni Kasa Ekle";
    List args =
        ModalRoute.of(context)!.settings.arguments as List; // Update or Add New

    String formMode = args[0];

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 1100) {
        return webScaffold(pageTitle, formMode: formMode);
      } else {
        return mobileScaffold(pageTitle, formMode: formMode);
      }
    });
  }

  Scaffold webScaffold(String pageTitle, {required String formMode}) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: Row(
        children: [
          const ProjectSideNavMenu(),
          Expanded(
              flex: 8,
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 6,
                        child: formFields(),
                      ),
                      Expanded(
                        flex: 2,
                        child: submitButton(formMode: formMode),
                      )
                    ],
                  ))),
        ],
      ),
    );
  }

  Scaffold mobileScaffold(String pageTitle, {required String formMode}) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 24, right: 12, left: 12),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    flex: 6,
                    child: formFields(),
                  ),
                  Expanded(
                    flex: 2,
                    child: submitButton(formMode: formMode),
                  )
                ],
              ))),
    );
  }

  ListView formFields() {
    return ListView(children: [
      textFormField(
          hintText: "Kasa Markası",
          isRequired: true,
          controller: _caseBrandController),
      const SizedBox(height: 40),
      textFormField(
          hintText: "Kasa Modeli",
          controller: _caseModelController,
          isRequired: true,
          icon: MdiIcons.fridgeIndustrial),
      const SizedBox(height: 40),
      textFormField(
          hintText: "Seri Numarası",
          controller: _serialNumberController,
          icon: MdiIcons.barcodeScan),
      const SizedBox(height: 40),
      textFormField(
          hintText: "Araç Bilgileri",
          controller: _vehicleInformationController,
          icon: Icons.local_shipping),
      const SizedBox(height: 40),
      textFormField(
          hintText: "Arka Kapı",
          controller: _rearDoorController,
          icon: MdiIcons.doorSliding),
      const SizedBox(height: 40),
      textFormField(
          hintText: "Kompresör Markası",
          controller: _compressorBrandController,
          icon: MdiIcons.airFilter),
      const SizedBox(height: 40),
      textFormField(
          hintText: "Kompresör Modeli",
          controller: _compressorModelController,
          icon: MdiIcons.airFilter),
      const SizedBox(height: 40),
      textFormField(
          hintText: "Kompresör Durumu",
          controller: _compressorStatusController,
          icon: MdiIcons.listStatus),
      const SizedBox(height: 40),
      textFormField(
          hintText: "Ötektik Plaka Modeli",
          controller: _euteticPlateModelController,
          icon: MdiIcons.snowflakeThermometer),
      const SizedBox(height: 40),
      textFormField(
          hintText: "Ötektik Plaka Ölçüleri",
          controller: _euteticPlateMeasurementsController,
          icon: MdiIcons.rulerSquare),
      const SizedBox(height: 40),
      textFormField(
          hintText: "Ötektik Plaka Sayısı",
          controller: _euteticPlateNumberController,
          icon: MdiIcons.counter),
      const SizedBox(height: 40),
      textFormField(
          hintText: "Ötektik Plaka Durumu",
          controller: _euteticPlateStatusController,
          icon: MdiIcons.listStatus),
      const SizedBox(height: 40),
      textFormField(
          hintText: "İç Tesisat Durumu",
          controller: _interiorInstallationStatusController,
          icon: MdiIcons.hammerWrench),
      const SizedBox(height: 40),
      textFormField(
          hintText: "Gaz Durumu",
          controller: _gasStatusController,
          icon: MdiIcons.gasCylinder),
      const SizedBox(height: 40),
      textFormField(
          hintText: "Not:",
          controller: _extraNotesController,
          icon: MdiIcons.text),
      const SizedBox(height: 40),
    ]);
  }

  TextFormField textFormField(
      {required String hintText,
      required TextEditingController controller,
      bool? isRequired,
      IconData? icon}) {
    icon == null ? icon = Icons.abc : icon = icon;
    isRequired == null ? isRequired = false : isRequired = isRequired;
    return TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
          prefixIcon: Icon(icon),
        ),
        validator: (value) {
          if (value!.isEmpty && isRequired!) {
            return '$hintText Boş Olamaz';
          }
          return null;
        });
  }

  Padding submitButton({required String formMode}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              saveAndNavigate(formMode: formMode);
            }
          },
          child: const SizedBox(
            height: 100,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Yeni Kasa Ekle",
              ),
            ),
          )),
    );
  }

  void saveAndNavigate({required String formMode}) {
    try {
      print("screeen");
      RefrigerationViewModel customerVm = RefrigerationViewModel();
      const snackBar = SnackBar(
        content: Text('Kaydediliyor...'),
        duration: Duration(milliseconds: 500),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      try {
        String caseBrand = _caseBrandController.text;
        String caseModel = _caseModelController.text;
        String serialNumber = _serialNumberController.text;
        String rearDoor = _rearDoorController.text;
        String vehicleInformation = _vehicleInformationController.text;
        String compressorBrand = _compressorBrandController.text;

        String compressorModel = _compressorBrandController.text;
        String compressorStatus = _compressorStatusController.text;
        String euteticPlateModel = _euteticPlateModelController.text;
        String euteticPlateMeasurement =
            _euteticPlateMeasurementsController.text;
        String euteticPlateNumber = _euteticPlateNumberController.text;
        String euteticPlateStatus = _euteticPlateStatusController.text;
        String interiorInstallationStatus =
            _interiorInstallationStatusController.text;
        String gasStatus = _gasStatusController.text;
        String extraNotes = _extraNotesController.text;

        Refrigeration refrigeration = Refrigeration(
          caseBrand: caseBrand,
          caseModel: caseModel,
          rearDoor: rearDoor,
          serialNumber: serialNumber,
          vehicleInformation: vehicleInformation,
          compressorBrand: compressorBrand,
          compressorModel: compressorModel,
          compressorStatus: compressorStatus,
          euteticPlateModel: euteticPlateModel,
          euteticPlateMeasurement: euteticPlateMeasurement,
          euteticPlateNumber: euteticPlateNumber,
          euteticPlateStatus: euteticPlateStatus,
          interiorInstallationStatus: interiorInstallationStatus,
          gasStatus: gasStatus,
          extraNotes: extraNotes,
        );

        customerVm.addRefrigeration(refrigeration: refrigeration);
      } catch (e) {
        print(e.toString());
      }

      Navigator.of(context).pushNamed("/refrigerations");
    } catch (e) {
      print(e.toString());
    }
  }
}
