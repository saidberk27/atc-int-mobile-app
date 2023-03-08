import 'package:intl/intl.dart';

class Time {
  static String getToday() {
    var now = DateTime.now();
    var formatter = DateFormat('dd/MM/yyyy');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  static String getTimeStamp() {
    var now = DateTime.now();
    var formatter = DateFormat("yyyy-MM-dd HH:mm:ss");
    String formattedDate = formatter.format(now);
    return formattedDate;
  }
}
