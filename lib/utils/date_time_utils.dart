import 'package:intl/intl.dart';

abstract class DateTimeUtils {
  static final _format = DateFormat('dd/MM/yyyy HH:mm:ss.SSS');

  static String dateToBRLFormat(DateTime data) {
    return _format.format(data);
  }

  static DateTime fromBRLFormat(String date) {
    return _format.parseStrict(date);
  }
}
