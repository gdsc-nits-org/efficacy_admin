import 'package:intl/intl.dart';

String formattedDateTime(DateTime dateTime) {
  final formatter = DateFormat('h:mm a, MMM d');
  return formatter.format(dateTime);
}
