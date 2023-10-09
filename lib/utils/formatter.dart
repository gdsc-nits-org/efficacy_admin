import 'package:intl/intl.dart';

class Formatter {
  const Formatter._();

  static String dateTime(DateTime dateTime) {
    final formatter = DateFormat('h:mm a, MMM d');
    return formatter.format(dateTime);
  }
}
