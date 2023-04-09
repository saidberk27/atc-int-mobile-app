import 'package:atc_international/data/viewmodel/worker_vm.dart';
import 'package:atc_international/local_components/colors.dart';
import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:atc_international/local_components/drawer.dart';
import 'package:atc_international/local_components/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddNewWorkerForm extends StatefulWidget {
  const AddNewWorkerForm({super.key});

  @override
  State<AddNewWorkerForm> createState() => _AddNewWorkerFormState();
}

class _AddNewWorkerFormState extends State<AddNewWorkerForm> {
  int _index = 0;
  final TextEditingController _customerController = TextEditingController();
  final TextEditingController _fridgeNoController = TextEditingController();
  final TextEditingController _leavetTimeController = TextEditingController();
  final TextEditingController _arriveTimeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _partsMustChangeController =
      TextEditingController();
  final TextEditingController _otherCommentsController =
      TextEditingController();
  final TextEditingController _vehicleHealthStatusController =
      TextEditingController();
  final TextEditingController _serviceLocationController =
      TextEditingController();
  final TextEditingController _vehicleInfoController = TextEditingController();

  bool _coldenGeneralControl = false;
  bool _compressor = false;
  bool _gasControl = false;
  bool _condensator = false;

  bool _gasLeakControl = false;
  bool _honeyComb = false;
  bool _connectionControls = false;
  bool _allConnectionPipesControls = false;

  bool _sidePanels = false;
  bool _frontPanel = false;
  bool _floorPanel = false;
  bool _floorDrenage = false;
  bool _panelHoneycombConnectionStatus = false;
  bool _fridgeIsolationStatus = false;
  bool _fridgeInnerOuterElectricityControl = false;
  bool _fridgeDoorConnectionControl = false;
  bool _fridgeConnectionScrewControl = false;

  bool _doorIsolationStatus = false;
  bool _doorPlastic = false;
  bool _locks = false;
  bool _rearDoorFrameStatus = false;
  bool _rearDoorStands = false;

  bool _floor = false;
  bool _honeycombs = false;
  bool _pipes = false;
  bool _innerSeperations = false;
  bool _lights = false;
  bool _roofAndOthers = false;

  bool _approveForm = false;

  @override
  Widget build(BuildContext context) {
    List<Step> formSteps = customSteps(context);
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 1100) {
        return webScaffold(formSteps);
      } else {
        return mobileScaffold(formSteps);
      }
    });
  }

  Scaffold webScaffold(List<Step> formSteps) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Yeni Form Ekle"),
        ),
        body: Row(
          children: [
            ProjectSideNavMenu(),
            Expanded(
              flex: 8,
              child: Stepper(
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
              ),
            ),
          ],
        ));
  }

  Scaffold mobileScaffold(List<Step> formSteps) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Yeni Form Ekle"),
        ),
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

  List<Step> customSteps(BuildContext context) {
    return <Step>[
      Step(
          // continue ve cancel butonlarını özelleştirmek için material_localizations.dart dosyasında değişiklik yaptım. String get continueButtonLabel => 'Devam Et';
          title: const Text('Genel Bilgiler'),
          content: generalInfoForm(context)),
      Step(title: const Text('Soğutma Ünitesi'), content: coldenUnitForm()),
      Step(
        title: const Text('Petekler'),
        content: honeyCombsForm(),
      ),
      Step(
        title: const Text('Tüm Paneller'),
        content: allPanelsForm(),
      ),
      Step(
        title: const Text('Arka Kapı'),
        content: rearDoorForm(),
      ),
      Step(
        title: const Text('Kasa İç Aksamlar'),
        content: fridgeInteriorForm(),
      ),
      Step(
        title: const Text('Değişmesi Gereken Parçalar'),
        content: textFormField(
            hintText: "Parçaları Giriniz...",
            controller: _partsMustChangeController),
      ),
      Step(
        title: const Text('Araç Ömür Durumu'),
        content: textFormField(
            hintText: "Durum Giriniz... ",
            controller: _vehicleHealthStatusController),
      ),
      Step(
        title: const Text('Kasa ile İlgili Servis Dışı Yorumlar'),
        content: Column(
          children: [
            textFormField(
                hintText: "Yorumları Giriniz...",
                controller: _otherCommentsController),
            CustomCheckBoxListTile(
                title: "Formu Onaylıyorum",
                value: _approveForm,
                onChanged: (bool? value) {
                  setState(() {
                    _approveForm = value!;
                  });
                })
          ],
        ),
      ),
      Step(
        title: const Text('Kaydet ve Gönder'),
        content: ElevatedButton(
            onPressed: () {
              JobForm jobForm = JobForm(
                  customerName: _customerController.text,
                  fridgeNo: _fridgeNoController.text,
                  vehiclePlateAndInfo: _vehicleInfoController.text,
                  serviceLocation: _locationController.text,
                  arrivalTime: _arriveTimeController.text,
                  leaveTime: _leavetTimeController.text,
                  finishDate: _dateController.text,
                  partsMustChange: _partsMustChangeController.text,
                  vehicleHealthStatus: _vehicleHealthStatusController.text,
                  otherComments: _otherCommentsController.text,
                  coldenGeneralControl: _coldenGeneralControl,
                  compressor: _compressor,
                  gasControl: _gasControl,
                  condensator: _condensator,
                  gasLeakControl: _gasLeakControl,
                  honeyComb: _honeyComb,
                  connectionControls: _connectionControls,
                  allConnectionPipesControls: _allConnectionPipesControls,
                  sidePanels: _sidePanels,
                  frontPanel: _frontPanel,
                  floorPanel: _floorPanel,
                  floorDrenage: _floorDrenage,
                  panelHoneycombConnectionStatus:
                      _panelHoneycombConnectionStatus,
                  fridgeIsolationStatus: _fridgeIsolationStatus,
                  fridgeInnerOuterElectricityControl:
                      _fridgeInnerOuterElectricityControl,
                  fridgeDoorConnectionControl: _fridgeDoorConnectionControl,
                  fridgeConnectionScrewControl: _fridgeConnectionScrewControl,
                  doorIsolationStatus: _doorIsolationStatus,
                  doorPlastic: _doorPlastic,
                  locks: _locks,
                  rearDoorFrameStatus: _rearDoorFrameStatus,
                  rearDoorStands: _rearDoorStands,
                  floor: _floor,
                  honeycombs: _honeycombs,
                  pipes: _pipes,
                  innerSeperations: _innerSeperations,
                  lights: _lights,
                  roofAndOthers: _roofAndOthers,
                  approveForm: _approveForm);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Form Kaydediliyor ...")));
              WorkerViewModel().addForm(jobForm: jobForm);
              Navigator.pushNamed(context, "/workerForms");
            },
            child: const SizedBox(
              height: 100,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "FORMU KAYDET VE GÖNDER",
                  textAlign: TextAlign.center,
                ),
              ),
            )),
      ),
    ];
  }

  Form fridgeInteriorForm() {
    return Form(
        child: Column(
      children: [
        CustomCheckBoxListTile(
            title: "Zemin",
            value: _floor,
            onChanged: (bool? value) {
              setState(() {
                _floor = value!;
              });
            }),
        const SizedBox(height: 20),
        CustomCheckBoxListTile(
            title: "Petekler",
            value: _honeycombs,
            onChanged: (bool? value) {
              setState(() {
                _honeycombs = value!;
              });
            }),
        const SizedBox(height: 20),
        CustomCheckBoxListTile(
            title: "Borular",
            value: _pipes,
            onChanged: (bool? value) {
              setState(() {
                _pipes = value!;
              });
            }),
        const SizedBox(height: 20),
        CustomCheckBoxListTile(
            title: "İç Bölme ve Seperatörler",
            value: _innerSeperations,
            onChanged: (bool? value) {
              setState(() {
                _innerSeperations = value!;
              });
            }),
        const SizedBox(height: 20),
        CustomCheckBoxListTile(
            title: "Lambalar",
            value: _lights,
            onChanged: (bool? value) {
              setState(() {
                _lights = value!;
              });
            }),
        const SizedBox(height: 20),
        CustomCheckBoxListTile(
            title: "Çatı ve Diğer Ekler",
            value: _roofAndOthers,
            onChanged: (bool? value) {
              setState(() {
                _roofAndOthers = value!;
              });
            }),
        const SizedBox(height: 20),
      ],
    ));
  }

  Form rearDoorForm() {
    return Form(
        child: Column(
      children: [
        CustomCheckBoxListTile(
            title: "Kapı İzolasyon Durumu",
            value: _doorIsolationStatus,
            onChanged: (bool? value) {
              setState(() {
                _doorIsolationStatus = value!;
              });
            }),
        CustomCheckBoxListTile(
            title: "Kapı Lastikleri",
            value: _doorPlastic,
            onChanged: (bool? value) {
              setState(() {
                _doorPlastic = value!;
              });
            }),
        CustomCheckBoxListTile(
            title: "Kilitler",
            value: _locks,
            onChanged: (bool? value) {
              setState(() {
                _locks = value!;
              });
            }),
        CustomCheckBoxListTile(
            title: "Arka Kapı Çerçeve Durumu",
            value: _rearDoorFrameStatus,
            onChanged: (bool? value) {
              setState(() {
                _rearDoorFrameStatus = value!;
              });
            }),
        CustomCheckBoxListTile(
            title: "Arka Kapı Destekleri",
            value: _rearDoorStands,
            onChanged: (bool? value) {
              setState(() {
                _rearDoorStands = value!;
              });
            }),
        const SizedBox(height: 20),
      ],
    ));
  }

  Form allPanelsForm() {
    return Form(
        child: Column(
      children: [
        CustomCheckBoxListTile(
            title: "Yan Panellerin Durumu",
            value: _sidePanels,
            onChanged: (bool? value) {
              setState(() {
                _sidePanels = value!;
              });
            }),
        const SizedBox(height: 20),
        CustomCheckBoxListTile(
            title: "Ön Panel Durumu",
            value: _frontPanel,
            onChanged: (bool? value) {
              setState(() {
                _frontPanel = value!;
              });
            }),
        const SizedBox(height: 20),
        CustomCheckBoxListTile(
            title: "Zemin Panel Durumu",
            value: _floorPanel,
            onChanged: (bool? value) {
              setState(() {
                _floorPanel = value!;
              });
            }),
        const SizedBox(height: 20),
        CustomCheckBoxListTile(
            title: "Zemin Drenaj Kontrolü",
            value: _floorDrenage,
            onChanged: (bool? value) {
              setState(() {
                _floorDrenage = value!;
              });
            }),
        const SizedBox(height: 20),
        CustomCheckBoxListTile(
            title: "Panel Petek Bağlantı Kontrolü",
            value: _panelHoneycombConnectionStatus,
            onChanged: (bool? value) {
              setState(() {
                _panelHoneycombConnectionStatus = value!;
              });
            }),
        const SizedBox(height: 20),
        CustomCheckBoxListTile(
            title: "Kasa Izalasyon Kontrolü",
            value: _fridgeIsolationStatus,
            onChanged: (bool? value) {
              setState(() {
                _fridgeIsolationStatus = value!;
              });
            }),
        const SizedBox(height: 20),
        CustomCheckBoxListTile(
            title: "Kasa İç-Dış Elektrik Kontrolü",
            value: _fridgeInnerOuterElectricityControl,
            onChanged: (bool? value) {
              setState(() {
                _fridgeInnerOuterElectricityControl = value!;
              });
            }),
        const SizedBox(height: 20),
        CustomCheckBoxListTile(
            title: "Kasa Kapı Bağlantı Kontrolü",
            value: _fridgeDoorConnectionControl,
            onChanged: (bool? value) {
              setState(() {
                _fridgeDoorConnectionControl = value!;
              });
            }),
        const SizedBox(height: 20),
        CustomCheckBoxListTile(
            title: "Kasa Bağlantı Vidaları Kontrolü",
            value: _fridgeConnectionScrewControl,
            onChanged: (bool? value) {
              setState(() {
                _fridgeConnectionScrewControl = value!;
              });
            }),
      ],
    ));
  }

  Form honeyCombsForm() {
    return Form(
        child: Column(
      children: [
        CustomCheckBoxListTile(
            title: "Gaz Kaçağı Kontrolü",
            value: _gasLeakControl,
            onChanged: (bool? value) {
              setState(() {
                _gasLeakControl = value!;
              });
            }),
        const SizedBox(height: 20),
        CustomCheckBoxListTile(
            title: "Petek Arıza ve Pas Kontrolü",
            value: _honeyComb,
            onChanged: (bool? value) {
              setState(() {
                _honeyComb = value!;
              });
            }),
        const SizedBox(height: 20),
        CustomCheckBoxListTile(
            title: "Bağlantı Kontrolleri",
            value: _connectionControls,
            onChanged: (bool? value) {
              setState(() {
                _connectionControls = value!;
              });
            }),
        const SizedBox(height: 20),
        CustomCheckBoxListTile(
            title: "Tüm Bağlantı Boruları Kontrol",
            value: _allConnectionPipesControls,
            onChanged: (bool? value) {
              setState(() {
                _allConnectionPipesControls = value!;
              });
            }),
        const SizedBox(height: 20),
      ],
    ));
  }

  Form coldenUnitForm() {
    return Form(
      child: Column(
        children: [
          CustomCheckBoxListTile(
            title: "Soğutma Genel Kontrol",
            value: _coldenGeneralControl,
            onChanged: (bool? value) {
              setState(() {
                _coldenGeneralControl = value!;
              });
            },
          ),
          const SizedBox(height: 20),
          CustomCheckBoxListTile(
            title: "Kompresör",
            value: _compressor,
            onChanged: (bool? value) {
              setState(() {
                _compressor = value!;
              });
            },
          ),
          const SizedBox(height: 20),
          CustomCheckBoxListTile(
            title: "Gaz Kontrol",
            value: _gasControl,
            onChanged: (bool? value) {
              setState(() {
                _gasControl = value!;
              });
            },
          ),
          const SizedBox(height: 20),
          CustomCheckBoxListTile(
            title: "Kondensatör",
            value: _condensator,
            onChanged: (bool? value) {
              setState(() {
                _condensator = value!;
              });
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Form generalInfoForm(BuildContext context) {
    return Form(
      child: Column(
        children: [
          textFormField(
              icon: MdiIcons.accountTie,
              controller: _customerController,
              hintText: "Müşteri:"),
          const SizedBox(height: 20),
          textFormField(
              icon: MdiIcons.fridgeIndustrial,
              controller: _fridgeNoController,
              hintText: "Kasa No:"),
          const SizedBox(height: 20),
          textFormField(
              icon: MdiIcons.truck,
              controller: _vehicleInfoController,
              hintText: "Araç Plaka ve Bilgisi:"),
          const SizedBox(height: 20),
          textFormField(
              icon: Icons.location_on,
              controller: _locationController,
              hintText: "Servis Yeri"),
          const SizedBox(height: 20),
          timePicker(context,
              labelText: "Varış Saati", controller: _arriveTimeController),
          const SizedBox(height: 20),
          timePicker(context,
              labelText: "Ayrılış Saati", controller: _leavetTimeController),
          const SizedBox(height: 20),
          datePicker(context),
          const SizedBox(height: 20),
        ],
      ),
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

  TextFormField timePicker(BuildContext context,
      {required String labelText, required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          icon: const Icon(Icons.access_time), labelText: labelText),
      readOnly: true,
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialEntryMode: TimePickerEntryMode.input,
          initialTime: TimeOfDay.now(),
          builder: (BuildContext context, Widget? child) {
            return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!,
            );
          },
        );
        if (pickedTime != null) {
          String formattedTime = DateFormat('HH:mm').format(
            DateTime(2023, 4, 7, pickedTime.hour, pickedTime.minute),
          );
          setState(() {
            controller.text = formattedTime;
          });
        } else {
          debugPrint("Not selected");
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Tarih Seçmediniz!';
        }
        return null;
      },
    );
  }

  TextFormField datePicker(BuildContext context) {
    return TextFormField(
      controller: _dateController,
      decoration: const InputDecoration(
          icon: Icon(Icons.calendar_today), labelText: "Tamamlanma Tarihi"),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat("dd/MM/yyyy").format(pickedDate);

          setState(() {
            _dateController.text = formattedDate.toString();
          });
        } else {
          debugPrint("Not selected");
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Tarih Seçmediniz!';
        }
        return null;
      },
    );
  }
}

class CustomCheckBoxListTile extends StatefulWidget {
  final String title;
  final bool value;
  final Function(bool?) onChanged;

  const CustomCheckBoxListTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  _CustomCheckBoxListTileState createState() => _CustomCheckBoxListTileState();
}

class _CustomCheckBoxListTileState extends State<CustomCheckBoxListTile> {
  bool? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      activeColor: ProjectColor.red,
      title: Text(
        widget.title,
        style: ProjectTextStyle.darkBlueSmallStrong(context),
      ),
      value: _value,
      onChanged: (bool? value) {
        setState(() {
          _value = value;
        });
        widget.onChanged(_value);
      },
    );
  }
}
