import 'package:atc_international/data/viewmodel/customer_vm.dart';
import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:atc_international/screens/customers/customer.dart';
import 'package:flutter/material.dart';
import 'package:atc_international/local_components/profile_picture.dart';

import '../../local_components/drawer.dart';
import '../../local_components/fab.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});
  final String _pageTitle = "MÜŞTERİLERİM";
  @override
  Widget build(BuildContext context) {
    const fabtext = "Yeni Müşteri";
    return Scaffold(
      body: FutureBuilder(
        future: CustomerViewModel().getCustomers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return customerCard(context,
                    customerName: snapshot.data![index].customerName,
                    customerCompany: snapshot.data![index].customerCompany,
                    customerTitle: snapshot.data![index].customerTitle,
                    customerMail: snapshot.data![index].customerMail,
                    customerPhone: snapshot.data![index].customerPhone);
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      drawer: const ProjectDrawer(),
      appBar: AppBar(title: Text(_pageTitle)),
      floatingActionButton: const ProjectFAB(
        text: fabtext,
        route: "/addNewCustomer",
      ),
    );
  }

  Card customerCard(BuildContext context,
      {required String customerName,
      required String customerCompany,
      required String customerTitle,
      required String customerPhone,
      required String customerMail}) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ProfilePicture(radius: 30),
            Column(
              children: [
                Text(
                  customerName, //TODO take care of possible long names
                  style: ProjectTextStyle.redMediumStrong(context),
                ),
                Text(
                  customerCompany,
                  style: ProjectTextStyle.lightBlueSmallStrong(context),
                )
              ],
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () => debugPrint("Mesaj"),
                    icon: const Icon(Icons.chat_bubble)),
                IconButton(
                    onPressed: () => Navigator.pushNamed(context, "/customer",
                        arguments: ScreenArguments(
                            customerName: customerName,
                            customerCompany: customerCompany,
                            customerMail: customerMail,
                            customerPhone: customerPhone,
                            customerTitle: customerTitle)),
                    icon: const Icon(Icons.info_outlined))
              ],
            )
          ],
        ),
      ),
    );
  }
}
