import 'package:atc_international/data/viewmodel/customer_vm.dart';
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
    _caseNameController.dispose();
    _caseModelController.dispose();
    _outerMeasurementController.dispose();
    _innerMeasurementController.dispose();
    _vehicleChassisModelController.dispose();
    _workingTemperatureController.dispose();
    _coldenUnitController.dispose();
    _eutaticPlatesController.dispose();
    _dailyDoorController.dispose();
    _dealTimeController.dispose();
    _innerTemperatureDurationController.dispose();
    _caseWeightController.dispose();
    _innerVolumeController.dispose();
    _weightCapacityController.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _caseNameController = TextEditingController();
  final TextEditingController _caseModelController = TextEditingController();

  final TextEditingController _outerMeasurementController =
      TextEditingController();
  final TextEditingController _innerMeasurementController =
      TextEditingController();
  final TextEditingController _vehicleChassisModelController =
      TextEditingController();
  final TextEditingController _workingTemperatureController =
      TextEditingController();
  final TextEditingController _coldenUnitController = TextEditingController();
  final TextEditingController _eutaticPlatesController =
      TextEditingController();
  final TextEditingController _dailyDoorController = TextEditingController();
  final TextEditingController _dealTimeController = TextEditingController();
  final TextEditingController _caseWeightController = TextEditingController();
  final TextEditingController _innerVolumeController = TextEditingController();
  final TextEditingController _weightCapacityController =
      TextEditingController();
  final TextEditingController _innerTemperatureDurationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    const pageTitle = "Yeni Kasa Ekle";
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 1100) {
        return webScaffold(pageTitle);
      } else {
        return mobileScaffold(pageTitle);
      }
    });
  }

  Scaffold webScaffold(String pageTitle) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
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
                          hintText: "Kasa İsmi",
                          controller: _caseNameController),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "Kasa Modeli",
                          controller: _caseModelController,
                          icon: Icons.business),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "Dıştan Dışa Ölçütler",
                          controller: _outerMeasurementController,
                          icon: Icons.title),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "İçten İçe Ölçütler",
                          controller: _innerMeasurementController,
                          icon: Icons.email_outlined),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "Araç Şasi Modelleri",
                          controller: _vehicleChassisModelController,
                          icon: Icons.phone_callback_outlined),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "Araç Şasi Modelleri",
                          controller: _vehicleChassisModelController,
                          icon: Icons.phone_callback_outlined),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "Araç Şasi Modelleri",
                          controller: _vehicleChassisModelController,
                          icon: Icons.phone_callback_outlined),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "Araç Şasi Modelleri",
                          controller: _vehicleChassisModelController,
                          icon: Icons.phone_callback_outlined),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "Araç Şasi Modelleri",
                          controller: _vehicleChassisModelController,
                          icon: Icons.phone_callback_outlined),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "Araç Şasi Modelleri",
                          controller: _vehicleChassisModelController,
                          icon: Icons.phone_callback_outlined),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "Araç Şasi Modelleri",
                          controller: _vehicleChassisModelController,
                          icon: Icons.phone_callback_outlined),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "Araç Şasi Modelleri",
                          controller: _vehicleChassisModelController,
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

  Scaffold mobileScaffold(String pageTitle) {
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
                    child: ListView(children: [
                      textFormField(
                          hintText: "Kasa İsmi",
                          controller: _caseNameController),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "Kasa Modeli",
                          controller: _caseModelController,
                          icon: Icons.move_down_outlined),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "Dıştan Dışa Ölçütler",
                          controller: _outerMeasurementController,
                          icon: Icons.straighten_outlined),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "İçten İçe Ölçütler",
                          controller: _innerMeasurementController,
                          icon: Icons.aspect_ratio),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "Araç Şasi Modelleri",
                          controller: _vehicleChassisModelController,
                          icon: Icons.local_shipping),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "Çalışma Sıcaklık Aralığı",
                          controller: _workingTemperatureController,
                          icon: Icons.thermostat),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "Soğutma Ünitesi",
                          controller: _coldenUnitController,
                          icon: Icons.ac_unit),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "Ötektik Pleytler",
                          controller: _eutaticPlatesController,
                          icon: Icons.grid_on_rounded),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "Günlük Kapı Açılma Sayısı",
                          controller: _dailyDoorController,
                          icon: Icons.door_sliding),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "Dağıtım Zamanı",
                          controller: _dealTimeController,
                          icon: Icons.timelapse_sharp),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "İç Isı Değişim Süresi",
                          controller: _innerTemperatureDurationController,
                          icon: MdiIcons.timer),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "Kasa Ağırlığı",
                          controller: _caseWeightController,
                          icon: MdiIcons.weight),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "İç Hacim",
                          controller: _innerVolumeController,
                          icon: MdiIcons.cubeOutline),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "Yük Yükleme Kapasitesi",
                          controller: _weightCapacityController,
                          icon: MdiIcons.weightKilogram),
                    ]),
                  ),
                  Expanded(
                    flex: 2,
                    child: elevatedButton(),
                  )
                ],
              ))),
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
              "Yeni Kasa Ekle",
            ),
          ),
        ));
  }

  void saveAndNavigate() {
    CustomerViewModel customerVm = CustomerViewModel();
    const snackBar = SnackBar(content: Text('Kaydediliyor...'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    String customerName = _caseNameController.text;
    String customerCompany = _caseModelController.text;
    String customerTitle = _outerMeasurementController.text;
    String customerMail = _innerMeasurementController.text;
    String customerPhone = _vehicleChassisModelController.text;

    customerVm.saveCustomer(
        customerName: customerName,
        customerCompany: customerCompany,
        customerTitle: customerTitle,
        customerMail: customerMail,
        customerPhone: customerPhone);

    Navigator.of(context).pushNamed("/customers");
  }
}
