import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:atc_international/screens/agenda/add_new_task.dart';
import 'package:atc_international/screens/agenda/agenda.dart';
import 'package:atc_international/screens/customers/add_new_customer.dart';
import 'package:atc_international/screens/customers/customer.dart';
import 'package:atc_international/screens/customers/customers.dart';
import 'package:atc_international/screens/home_screen/home.dart';
import 'package:atc_international/screens/home_screen/notifications.dart';
import 'package:atc_international/screens/login/login.dart';
import 'package:atc_international/screens/messages/chats.dart';
import 'package:atc_international/screens/messages/custom_chat.dart';
import 'package:atc_international/screens/refrigerations/add_new_refrigeration.dart';
import 'package:atc_international/screens/refrigerations/refrigeration.dart';
import 'package:atc_international/screens/refrigerations/refrigerations.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'local_components/colors.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/agenda/completed_tasks.dart';

void main() async {
  await Hive.initFlutter();

  runApp(const MyApp());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: ProjectColor.customPrimarySwatch,
          scaffoldBackgroundColor: ProjectColor.white,
          appBarTheme: AppBarTheme(
            backgroundColor: ProjectColor.white,
            foregroundColor: ProjectColor.darkBlue,
            centerTitle: true,
            titleTextStyle: ProjectTextStyle.redMediumStrong(context),
            elevation: 0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                      color: ProjectColor.darkBlue, width: 2.5),
                  backgroundColor: ProjectColor.white,
                  alignment: const Alignment(0, 0),
                  textStyle: ProjectTextStyle.darkBlueMediumStrong(context),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  foregroundColor: ProjectColor.darkBlue))),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const MyHomePage(),
        '/notifications': (context) => const NotificationsPage(),
        '/customers': (context) => const CustomersPage(),
        '/customer': (context) => const CustomerPage(),
        '/refrigerations': (context) => const Refrigerations(),
        '/refrigeration': (context) => const Refrigeration(),
        '/agenda': (context) => const AgendaPage(),
        "/addNewRefrigeration": (context) => const AddNewRefrigeration(),
        "/addNewTask": (context) => const AddNewTask(),
        "/addNewCustomer": (context) => const AddNewCustomer(),
        "/completedTasks": (context) => const CompletedTasksPage(),
        "/chats": (context) => const ChatsPage(),
        "/customChat": (context) => const CustomChatPage()
      },
    );
  }
}
