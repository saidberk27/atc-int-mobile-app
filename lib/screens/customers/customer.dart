import 'package:atc_international/data/viewmodel/customer_vm.dart';
import 'package:atc_international/local_components/colors.dart';
import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:atc_international/local_components/shorten_string.dart';
import 'package:flutter/material.dart';

import '../../local_components/profile_picture.dart';

class CustomerPage extends StatelessWidget {
  const CustomerPage({super.key, String? customerName});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          userTitle(context,
              customerName: args.customerName,
              customerCompany: args.customerCompany),
          const Divider(
            thickness: 2,
            color: ProjectColor.red,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                chatBubbleRow(context, customerName: args.customerName),
                normalRow(context, "Çalıştığı Şirket: ", args.customerCompany),
                normalRow(context, "Unvan: ", args.customerTitle),
                normalRow(context, "E-Posta: ", args.customerMail),
                normalRow(context, "Telefon: ", args.customerPhone),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
                onPressed: () {
                  deleteCustomer(context, id: args.customerID);
                },
                child: Text("Müşteriyi Sil")),
          )
        ],
      ),
    );
  }

  SizedBox chatBubbleRow(BuildContext context, {required String customerName}) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Text(
            "İsim Soyisim: ",
            style: ProjectTextStyle.redSmallStrong(context),
          ),
          Text(
            customerName,
            style: ProjectTextStyle.lightBlueSmallStrong(context),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => debugPrint("null"),
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
      {required String customerName, required String customerCompany}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ProfilePicture(radius: 60),
        Column(
          children: [
            Text(
              shortenString(string: customerName, max_length: 14),
              style: ProjectTextStyle.lightBlueBigStrong(context),
            ),
            Text(
              customerCompany,
              style: ProjectTextStyle.redMediumStrong(context),
            ),
          ],
        )
      ],
    );
  }

  void deleteCustomer(context, {required String id}) {
    CustomerViewModel().deleteCustomer(id: id);
    Navigator.of(context).pushNamed("/customers");
  }
}

class ScreenArguments {
  final String customerName;
  final String customerCompany;
  final String customerTitle;
  final String customerMail;
  final String customerPhone;
  final String customerID;

  ScreenArguments(
      {required this.customerCompany,
      required this.customerMail,
      required this.customerName,
      required this.customerPhone,
      required this.customerTitle,
      required this.customerID});
}
