import 'package:atc_international/local_components/colors.dart';
import 'package:flutter/material.dart';

import '../../local_components/custom_text_themes.dart';

class Refrigeration extends StatelessWidget {
  const Refrigeration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EUTETIC 4300 4.5T"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            normalRow(
                context, "Model:  ", "Eutectic 4300 Dondurma kasası 4.5T "),
            normalRow(context, "Yan kapı sayısı:  ", "4+4 "),
            normalRow(context, "Dıştan dışa ölçüler:  ", "4250x2100x1700mm "),
            normalRow(context, "Içten içe ölçüler:  ", "4140x1890x1475mm "),
            normalRow(context, "Araç Şasi Modelleri:  ",
                "Iveco Daily, \nMercedes-Benz Sprinter"),
            normalRow(
                context, "Çalışma sıcaklık aralığı:  ", " −40°C to −20°C "),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 4, color: ProjectColor.darkBlue),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: Image.network(
                  "https://www.atcint.com.tr/tr/kaynak/yuklemeler/urunler/urunler/detay/187_eutecticplatesinatcint.png"),
            )
          ],
        ),
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
}
