import 'dart:math';
import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/pages/upload_event/widgets/custom_drop_down.dart';
import 'package:flutter/material.dart';

Size size = 0 as Size;

void getSize(BuildContext context) {
  size = MediaQuery.of(context).size;
}

//screen size
double width = size.width;
double height = size.height;
//constants
double buttonHeight = height * 0.04;
double buttonLeftPos = width * 0.3;
double buttonTopPos = height * 0.16;
double containerRadius = 30.0;
double buttonWidth = width * 0.4;
double borderWidth = 2;
double iconSize = 25;
double padding = 16;
double lineWidth = min(width * 0.4, 100);
double linePadding = width * 0.3;
double gap = 40;
double fontSize = 20;
double endGap = height * 0.1;
//color
Color textColor = dark;

TextEditingController titleController = TextEditingController();
TextEditingController clubIDController = TextEditingController();
TextEditingController shortDescController = TextEditingController();
TextEditingController longDescController = TextEditingController();
TextEditingController googleUrlController = TextEditingController();
TextEditingController fbUrlController = TextEditingController();
TextEditingController venueController = TextEditingController();

Moderator? selectedModerator;

DateTime selectedDate1 = DateTime.now();
DateTime selectedDate2 = DateTime.now();
TimeOfDay selectedTime1 = TimeOfDay.now();
TimeOfDay selectedTime2 = TimeOfDay.now();
