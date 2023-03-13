import 'package:cloud_firestore/cloud_firestore.dart';

import '../../local_components/get_today.dart';
import '../model/project_firestore.dart';

class CustomerViewModel {
  Future<void> saveCustomer(
      {required String customerName,
      required String customerCompany,
      required String customerTitle,
      required String customerMail,
      required String customerPhone}) async {
    Customer.toJson(
        customerName: customerName,
        customerCompany: customerCompany,
        customerTitle: customerTitle,
        customerMail: customerMail,
        customerPhone: customerPhone);
  }
}

class Customer {
  Customer.toJson(
      {required String customerName,
      required String customerCompany,
      required String customerTitle,
      required String customerMail,
      required String customerPhone}) {
    DateTime customerAddedDate = DateTime.parse(Time.getTimeStamp());
    Timestamp customerTimeStamp = Timestamp.fromDate(customerAddedDate);

    final customer = <String, dynamic>{
      "customer_name": customerName,
      "customer_company": customerCompany,
      "customer_title": customerTitle,
      "customer_mail": customerMail,
      "customer_phone": customerPhone,
      "customer-added": customerTimeStamp
    };

    ProjectFirestore().writeToDocument(
        collectionPath: "/customers/customers/customers", json: customer);
  }
}
