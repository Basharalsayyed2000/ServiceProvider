import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

String getDateNow() {
    initializeDateFormatting();
    DateTime now = DateTime.now();
// ignore: unused_local_variable
    var dateString = DateFormat('dd-MM-yyyy').format(now);
    final String configFileName = dateString;
    return configFileName;
}
