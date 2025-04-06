import 'package:intl/intl.dart';

abstract class DateTimeUtils {
  static String dateToBRLFormat(DateTime data) {
    return DateFormat('dd/MM/yyyy').format(data);
  }

  static DateTime fromBRLFormat(String date) {
    return DateFormat('dd/MM/yyyy').parseStrict(date);
  }
}
