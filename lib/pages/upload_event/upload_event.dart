import 'dart:io';

import 'package:efficacy_admin/config/config.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//moderator class
class Moderator {
  String name;

  Moderator(this.name);
}

class UploadEvent extends StatefulWidget {
  //route
  static const String routeName = '/UploadPage';

  const UploadEvent({super.key});

  @override
  State<UploadEvent> createState() => _UploadEventState();
}

class _UploadEventState extends State<UploadEvent> {
  //form variables
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController shortDescController = TextEditingController();
  TextEditingController longDescController = TextEditingController();
  TextEditingController googleUrlController = TextEditingController();
  TextEditingController fbUrlController = TextEditingController();

  //form validate function
  void _validateForm() {
    if (_formKey.currentState!.validate()) {
      //validation logic
    } else {}
  }

  //moderator declaration
  List<Moderator> moderators = [
    Moderator('John Doe'),
    Moderator('Jane Doe'),
    Moderator('Jim Doe'),
  ];

  Moderator? selectedModerator;

  //image variable
  File? _image;

  //function to get image from gallery
  Future _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {}
    });
  }

  //date time variables
  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  TimeOfDay selectedTime1 = TimeOfDay.now();
  TimeOfDay selectedTime2 = TimeOfDay.now();

  //function to get dates
  Future<void> _selectDate(BuildContext context, int pickerNumber) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: pickerNumber == 1 ? selectedDate1 : selectedDate2,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        if (pickerNumber == 1) {
          selectedDate1 = picked;
        } else {
          selectedDate2 = picked;
        }
      });
    }
  }

  //function to get times
  Future<void> _selectTime(BuildContext context, int pickerNumber) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: pickerNumber == 1 ? selectedTime1 : selectedTime2,
    );

    if (picked != null) {
      setState(() {
        if (pickerNumber == 1) {
          selectedTime1 = picked;
        } else {
          selectedTime2 = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //screen size
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    //constants
    double buttonLeftPos = width * 0.3;
    double buttonTopPos = height * 0.16;
    double buttonHeight = height * 0.04;
    double buttonWidth = width * 0.4;
    double containerRadius = 30.0;
    double borderWidth = 2;
    double boxRadius = 5;
    double iconSize = 30;
    double padding = 16;
    double lineWidth = width * 0.4;
    double linePadding = width * 0.3;
    double gap = 40;
    double fontSize = 25;
    double buttonFontSize = 22;
    double dateTimeFontSize = 20;
    double dropDownWidth = width * 0.45;
    double endGap = height * 0.1;
    //color
    Color textColor = const Color.fromRGBO(5, 53, 76, 1);

    return Scaffold(
      floatingActionButton: SizedBox(
        width: buttonWidth,
        child: FloatingActionButton(
          onPressed: _validateForm,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                Icons.file_upload_outlined,
                size: 30,
              ),
              Text(
                'Upload',
                style: TextStyle(fontSize: buttonFontSize),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  _image == null
                      ? Image.asset(
                          "assets/images/media.png",
                          width: width,
                          fit: BoxFit.fitWidth,
                        )
                      : Image.file(
                          _image!,
                        ),
                  Positioned(
                      left: buttonLeftPos,
                      top: buttonTopPos,
                      child: SizedBox(
                        height: buttonHeight,
                        width: buttonWidth,
                        child: ElevatedButton(
                            onPressed: _getImage,
                            child: const Text("Change poster")),
                      ))
                ],
              ),
              Form(
                  key: _formKey,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(containerRadius),
                            topRight: Radius.circular(containerRadius))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //line
                        Padding(
                          padding: EdgeInsets.only(top: gap, left: linePadding),
                          child: Container(
                            color: Colors.grey,
                            height: borderWidth,
                            width: lineWidth,
                          ),
                        ),
                        //title
                        Padding(
                          padding:
                              EdgeInsets.only(left: padding, right: padding),
                          child: TextFormField(
                            controller: titleController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Title cannot be empty";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: borderWidth),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(boxRadius))),
                                hintText: 'Event Title',
                                icon: Icon(
                                  Icons.title,
                                  size: iconSize,
                                  color: Colors.black54,
                                )),
                          ),
                        ),
                        //short description
                        Padding(
                          padding:
                              EdgeInsets.only(left: padding, right: padding),
                          child: TextFormField(
                            controller: shortDescController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Description cannot be empty";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: borderWidth),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(boxRadius))),
                                hintText: 'Short Description',
                                icon: Icon(
                                  Icons.format_align_right_rounded,
                                  size: iconSize,
                                  color: Colors.black54,
                                )),
                          ),
                        ),
                        //long description
                        Padding(
                          padding:
                              EdgeInsets.only(left: padding, right: padding),
                          child: TextFormField(
                            controller: longDescController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Description cannot be empty";
                              }
                              return null;
                            },
                            maxLines: 8,
                            maxLength: 500,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: borderWidth),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(boxRadius))),
                                hintText: 'Long Description',
                                icon: Icon(
                                  Icons.format_align_right_rounded,
                                  size: iconSize,
                                  color: Colors.black54,
                                )),
                          ),
                        ),
                        //start date and time
                        Padding(
                          padding: EdgeInsets.only(left: padding),
                          child: Text(
                            "Start Date & Time",
                            style: TextStyle(
                                color: textColor,
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        //Date and time picker
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () => _selectDate(context, 1),
                              child: Icon(
                                Icons.calendar_today_outlined,
                                color: textColor,
                                size: iconSize,
                              ),
                            ),
                            InkWell(
                              onTap: () => _selectDate(context, 1),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Date",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: dateTimeFontSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${selectedDate1.toLocal()}".split(' ')[0],
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: dateTimeFontSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => _selectTime(context, 1),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Time",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: dateTimeFontSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    selectedTime1.format(context),
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: dateTimeFontSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        //end date and time
                        Padding(
                          padding: EdgeInsets.only(left: padding),
                          child: Text(
                            "End Date & Time",
                            style: TextStyle(
                                color: const Color.fromRGBO(5, 53, 76, 1),
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        //date and time picker
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () => _selectDate(context, 2),
                              child: Icon(
                                Icons.calendar_today_outlined,
                                color: textColor,
                                size: iconSize,
                              ),
                            ),
                            InkWell(
                              onTap: () => _selectDate(context, 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Date",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: dateTimeFontSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${selectedDate2.toLocal()}".split(' ')[0],
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: dateTimeFontSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => _selectTime(context, 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Time",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: dateTimeFontSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    selectedTime2.format(context),
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: dateTimeFontSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        //google form
                        Padding(
                          padding:
                              EdgeInsets.only(left: padding, right: padding),
                          child: TextFormField(
                            controller: googleUrlController,
                            validator: (value) {
                              Uri uri = Uri.parse(value!);
                              if (!(uri.isAbsolute &&
                                  uri.hasScheme &&
                                  uri.hasAuthority)) {
                                return "Invalid URL";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.url,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: borderWidth),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(boxRadius))),
                                hintText: 'Google Form URL',
                                icon: Icon(
                                  Icons.link_outlined,
                                  size: iconSize,
                                  color: Colors.black54,
                                )),
                          ),
                        ),
                        //FB form URL
                        Padding(
                          padding:
                              EdgeInsets.only(left: padding, right: padding),
                          child: TextFormField(
                            controller: fbUrlController,
                            validator: (value) {
                              Uri uri = Uri.parse(value!);
                              if (!(uri.isAbsolute &&
                                  uri.hasScheme &&
                                  uri.hasAuthority)) {
                                return "Invalid URL";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.url,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: borderWidth),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(boxRadius))),
                                hintText: 'Facebook Form URL',
                                icon: Icon(
                                  Icons.link_outlined,
                                  size: iconSize,
                                  color: Colors.black54,
                                )),
                          ),
                        ),
                        //Add Contacts
                        Padding(
                          padding: EdgeInsets.only(left: padding),
                          child: Text(
                            "Add Contacts",
                            style: TextStyle(
                                color: textColor,
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        //drop down menu
                        Padding(
                          padding: EdgeInsets.only(left: padding),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person_2_outlined,
                                color: Colors.black54,
                                size: iconSize,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: padding),
                                child: Container(
                                  padding: EdgeInsets.only(left: padding),
                                  width: dropDownWidth,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.black54)),
                                  child: DropdownButton<Moderator>(
                                    icon: const Icon(Icons.arrow_drop_down),
                                    hint: const Text('Add Moderators'),
                                    value: selectedModerator,
                                    onChanged: (Moderator? newValue) {
                                      setState(() {
                                        selectedModerator = newValue;
                                      });
                                    },
                                    items:
                                        moderators.map((Moderator moderator) {
                                      return DropdownMenuItem<Moderator>(
                                        value: moderator,
                                        child: Text(moderator.name),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //gap at the end
                        SizedBox(
                          height: endGap,
                        )
                      ].separate(padding),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
