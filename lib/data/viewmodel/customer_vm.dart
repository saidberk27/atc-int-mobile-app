import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../local_components/get_today.dart';
import '../model/project_firestore.dart';

class CustomerViewModel {
  List modelsList = [];
  ProjectFirestore db = ProjectFirestore();
  Future<List> getCustomers() async {
    //gets json and converts to datamodel.
    var customers = await db.readDocumentsFromDatabaseWithOrder(
        collectionPath: "/customers/customers/customers",
        orderField: "customer_added",
        isDescending: false);
    for (int i = 0; i < customers.length; i++) {
      modelsList.add(Customer.fromJson(json: customers[i]));
    }
    return modelsList;
  }

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

  Future<void> deleteCustomer({required String id}) async {
    db.removeFromDatabase(
        documentPath: "customers/customers/customers", id: id);
  }
}

class Customer {
  String? customerName;
  String? customerCompany;
  String? customerTitle;
  String? customerMail;
  String? customerPhone;
  String? id;
  Timestamp? customerTimeStamp;
  Customer.toJson(
      {required String this.customerName,
      required String this.customerCompany,
      required String this.customerTitle,
      required String this.customerMail,
      required String this.customerPhone}) {
    DateTime customerAddedDate = DateTime.parse(Time.getTimeStamp());
    Timestamp customerTimeStamp = Timestamp.fromDate(customerAddedDate);

    final customer = <String, dynamic>{
      "customer_name": customerName,
      "customer_company": customerCompany,
      "customer_title": customerTitle,
      "customer_mail": customerMail,
      "customer_phone": customerPhone,
      "customer_added": customerTimeStamp
    };

    ProjectFirestore().writeToDocument(
        collectionPath: "/customers/customers/customers", json: customer);
  }

  Customer.fromJson({required Map json}) {
    customerName = json["customer_name"];
    customerCompany = json["customer_company"];
    customerTitle = json["customer_title"];
    customerMail = json["customer_mail"];
    customerPhone = json["customer_phone"];
    customerTimeStamp = json["customer_added"];
    id = json["id"];
    // Timestamp to DateTime to String conversion
  }
}
