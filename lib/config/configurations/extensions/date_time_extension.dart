extension DateTimeExtension on DateTime {
  DateTime toStartOfDay() {
    return DateTime(year, month, day);
  }
}
