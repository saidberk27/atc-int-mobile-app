import 'package:atc_international/data/local/user_name.dart';
import 'package:atc_international/data/model/project_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../local_components/get_today.dart';
import '../model/project_firestore.dart';

class CustomerViewModel {
  List modelsList = [];
  ProjectFirestore db = ProjectFirestore();
  Future<List> getCustomers() async {
    String? userID = await UserName.getUserId();

    //gets json and converts to datamodel.
    var customers = await db.readDocumentsFromDatabaseWithOrder(
        collectionPath: "/users/$userID/customers/",
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
      required String customerPassword,
      required String customerPhone}) async {
    String? currentUserID = await UserName.getUserId();

    String createdUserID = await AuthRemoteDB().createCustomerUser(
        userEmail: customerMail,
        userPassword: customerPassword,
        userName: customerName);
    Customer.toJson(
        customerName: customerName,
        customerCompany: customerCompany,
        customerTitle: customerTitle,
        customerMail: customerMail,
        customerPassword: customerPassword,
        customerPhone: customerPhone,
        id: createdUserID,
        userID: currentUserID!);
  }

  Future<void> deleteCustomer({required String id}) async {
    String? userID = await UserName.getUserId();

    db.removeFromDatabase(documentPath: "users/$userID/customers", id: id);
//TODO Customer firestoer customers'den siliniyor. fakat id farklı oldugu icin ayni customer users'dan silinmiyor. Ayrıca hesap da kaldırılmıyor auth sistemden
    db.removeFromDatabase(documentPath: "users", id: id);
  }
}

class Customer {
  String? customerName;
  String? customerCompany;
  String? customerTitle;
  String? customerMail;
  String? customerPassword;
  String? customerPhone;
  String? id;
  Timestamp? customerTimeStamp;
  Customer.toJson(
      {required String this.customerName,
      required String this.customerCompany,
      required String this.customerTitle,
      required String this.customerMail,
      required String this.customerPassword,
      required String this.customerPhone,
      required String this.id,
      required String userID}) {
    DateTime customerAddedDate = DateTime.parse(Time.getTimeStamp());
    Timestamp customerTimeStamp = Timestamp.fromDate(customerAddedDate);

    final customer = <String, dynamic>{
      "customer_name": customerName,
      "customer_company": customerCompany,
      "customer_title": customerTitle,
      "customer_mail":
          customerMail, //Customer password will not be writed to firestore due to security reasons
      "customer_phone": customerPhone,
      "customer_added": customerTimeStamp
    };

    final user = <String, dynamic>{
      "user_name": customerName,
      "user_type": "customer",
    };

    ProjectFirestore()
        .addDocumentToCollectionWithID(path: "/users", json: user, ID: id!);

    ProjectFirestore().addDocumentToCollectionWithID(
        path: "/users/$userID/customers/", json: customer, ID: id!);
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
