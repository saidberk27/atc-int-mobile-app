import 'dart:typed_data';

import 'package:atc_international/data/viewmodel/refrigeration_vm.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

//TODO https://pub.dev/packages/mobile_scanner XCODE ayarlamalarını yap
class AddNewRefrigerationWithQrCode extends StatelessWidget {
  const AddNewRefrigerationWithQrCode({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDetected = false;
    Future<void> saveRefrigeration({required String barcodeRawValue}) async {
      Refrigeration refrigeration = Refrigeration(
          caseBrand: barcodeRawValue,
          caseModel: "",
          rearDoor: "",
          serialNumber: "",
          vehicleInformation: "",
          compressorBrand: "",
          compressorModel: "",
          compressorStatus: "",
          euteticPlateModel: "",
          euteticPlateMeasurement: "",
          euteticPlateNumber: "",
          euteticPlateStatus: "",
          interiorInstallationStatus: "",
          gasStatus: "",
          extraNotes: "");
      await RefrigerationViewModel()
          .addRefrigeration(refrigeration: refrigeration);
    }

    return Scaffold(
      appBar: AppBar(title: const Text("QR CODE İLE YENİ KASA EKLE")),
      body: MobileScanner(
        // fit: BoxFit.contain,
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.normal,
          facing: CameraFacing.front,
          torchEnabled: true,
        ),
        onDetect: (capture) async {
          if (!isDetected) {
            //added for make sure about barcode will be scanned only for one time
            isDetected = true;
            Navigator.pushNamed(context, "/refrigerations");
            final List<Barcode> barcodes = capture.barcodes;
            final Uint8List? image = capture.image;
            final barcode = barcodes[0];
            debugPrint('Barcode found! ${barcode.rawValue}');
            await saveRefrigeration(barcodeRawValue: barcode.rawValue!);
          }
        },
      ),
    );
  }
}
