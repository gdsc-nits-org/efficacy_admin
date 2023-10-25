import 'package:flutter/material.dart';

class DateTimePicker extends StatelessWidget {
  final String label;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final Function() onTapDate;
  final Function() onTapTime;

  const DateTimePicker({
    required this.label,
    required this.selectedDate,
    required this.selectedTime,
    required this.onTapDate,
    required this.onTapTime,
  });

  @override
  Widget build(BuildContext context) {
    //constants
    double iconSize = 25;
    double dateTimeFontSize = 16;

    //color
    Color textColor = const Color.fromRGBO(5, 53, 76, 1);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: onTapDate,
          child: Icon(
            Icons.calendar_today_outlined,
            color: textColor,
            size: iconSize,
          ),
        ),
        InkWell(
          onTap: onTapDate,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Date",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: dateTimeFontSize,
                ),
              ),
              Text(
                "${selectedDate.toLocal()}".split(' ')[0],
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: dateTimeFontSize,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: onTapTime,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Time",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: dateTimeFontSize,
                ),
              ),
              Text(
                selectedTime.format(context),
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: dateTimeFontSize,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
