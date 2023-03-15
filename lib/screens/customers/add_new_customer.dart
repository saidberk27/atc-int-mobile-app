import 'package:atc_international/data/viewmodel/customer_vm.dart';
import 'package:atc_international/local_components/nav_bar.dart';

import 'package:flutter/material.dart';

class AddNewCustomer extends StatefulWidget {
  const AddNewCustomer({super.key});

  @override
  State<AddNewCustomer> createState() => _AddNewCustomerState();
}

class _AddNewCustomerState extends State<AddNewCustomer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _customerNameController.dispose();
    _customerCompanyController.dispose();
    _customerTitleController.dispose();
    _customerMailController.dispose();
    _customerPhoneController.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _customerCompanyController =
      TextEditingController();

  final TextEditingController _customerTitleController =
      TextEditingController();
  final TextEditingController _customerMailController = TextEditingController();
  final TextEditingController _customerPhoneController =
      TextEditingController();

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
        title: const Text("Yeni Müşteri Ekle"),
      ),
      body: Row(
        children: [
          ProjectSideNavMenu(),
          Expanded(
            flex: 8,
            child: Padding(
                padding: const EdgeInsets.only(top: 24, right: 12, left: 12),
                child: Form(
                    key: _formKey,
                    child: ListView(children: [
                      textFormField(
                          hintText: "Müşteri İsmi",
                          controller: _customerNameController),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "Çalıştığı Şirket",
                          controller: _customerCompanyController,
                          icon: Icons.business),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "Unvan",
                          controller: _customerTitleController,
                          icon: Icons.title),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "E-Posta",
                          controller: _customerMailController,
                          icon: Icons.email_outlined),
                      const SizedBox(height: 40),
                      textFormField(
                          hintText: "Telefon",
                          controller: _customerPhoneController,
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
        title: const Text("Yeni Müşteri Ekle"),
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 24, right: 12, left: 12),
          child: Form(
              key: _formKey,
              child: ListView(children: [
                textFormField(
                    hintText: "Müşteri İsmi",
                    controller: _customerNameController),
                const SizedBox(height: 40),
                textFormField(
                    hintText: "Çalıştığı Şirket",
                    controller: _customerCompanyController,
                    icon: Icons.business),
                const SizedBox(height: 40),
                textFormField(
                    hintText: "Unvan",
                    controller: _customerTitleController,
                    icon: Icons.title),
                const SizedBox(height: 40),
                textFormField(
                    hintText: "E-Posta",
                    controller: _customerMailController,
                    icon: Icons.email_outlined),
                const SizedBox(height: 40),
                textFormField(
                    hintText: "Telefon",
                    controller: _customerPhoneController,
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
              "Yeni Müşteri Ekle",
            ),
          ),
        ));
  }

  void saveAndNavigate() {
    CustomerViewModel customerVm = CustomerViewModel();
    const snackBar = SnackBar(content: Text('Kaydediliyor...'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    String customerName = _customerNameController.text;
    String customerCompany = _customerCompanyController.text;
    String customerTitle = _customerTitleController.text;
    String customerMail = _customerMailController.text;
    String customerPhone = _customerPhoneController.text;

    customerVm.saveCustomer(
        customerName: customerName,
        customerCompany: customerCompany,
        customerTitle: customerTitle,
        customerMail: customerMail,
        customerPhone: customerPhone);

    Navigator.of(context).pushNamed("/customers");
  }
}
