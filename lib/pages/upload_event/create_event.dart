import 'dart:io';
import 'dart:math';
import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/pages/upload_event/widgets/custom_drop_down.dart';
import 'package:efficacy_admin/pages/upload_event/widgets/custom_text_field.dart';
import 'package:efficacy_admin/pages/upload_event/widgets/date_time_picker.dart';
import 'package:efficacy_admin/pages/upload_event/widgets/upload_button.dart';
import 'package:efficacy_admin/pages/upload_event/widgets/url_input.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CreateEvent extends StatefulWidget {
  //route
  static const String routeName = '/CreateEventPage';

  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
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
  Future<void> _getImage() async {
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
    Color textColor = const Color.fromRGBO(5, 53, 76, 1);

    return Scaffold(
      floatingActionButton: UploadButton(onPressed: _validateForm),
      body: SafeArea(
        child: SlidingUpPanel(
          maxHeight: height * .75,
          minHeight: height * .65,
          borderRadius: BorderRadius.circular(30),
          panelBuilder: (ScrollController scrollController) {
            return Form(
              key: _formKey,
              child: ListView(
                controller: scrollController,
                children: [
                  SizedBox(height: gap),
                  //line
                  Center(
                    child: Container(
                      color: Colors.grey,
                      height: borderWidth,
                      width: lineWidth,
                    ),
                  ),
                  //title
                  CustomField(
                    controller: titleController,
                    hintText: 'Event Title',
                    icon: Icons.title,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Title cannot be empty';
                      }
                      return null;
                    },
                  ),
                  //short description
                  CustomField(
                    controller: shortDescController,
                    icon: Icons.format_align_right_rounded,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Description cannot be empty';
                      }
                      return null;
                    },
                    hintText: 'Short Description',
                  ),
                  //long description
                  CustomField(
                    hintText: 'Long Description',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Description cannot be empty";
                      }
                      return null;
                    },
                    icon: Icons.format_align_right_rounded,
                    controller: longDescController,
                    maxLines: 6,
                  ),
                  //start date and time
                  Padding(
                    padding: EdgeInsets.only(left: padding),
                    child: Text(
                      "Start Date & Time",
                      style: TextStyle(
                        color: textColor,
                        fontSize: fontSize,
                      ),
                    ),
                  ),
                  //Date and time picker
                  DateTimePicker(
                    label: 'Start Date & Time',
                    selectedDate: selectedDate1,
                    selectedTime: selectedTime1,
                    onTapDate: () => _selectDate(context, 1),
                    onTapTime: () => _selectTime(context, 1),
                  ),
                  //end date and time
                  Padding(
                    padding: EdgeInsets.only(left: padding),
                    child: Text(
                      "End Date & Time",
                      style: TextStyle(
                        color: const Color.fromRGBO(5, 53, 76, 1),
                        fontSize: fontSize,
                      ),
                    ),
                  ),
                  //date and time picker
                  DateTimePicker(
                    label: 'End Date & Time',
                    selectedDate: selectedDate2,
                    selectedTime: selectedTime2,
                    onTapDate: () => _selectDate(context, 2),
                    onTapTime: () => _selectTime(context, 2),
                  ),
                  //google form
                  UrlInput(
                    controller: googleUrlController,
                    icon: Icons.link_outlined,
                    hintText: 'Google Form URL',
                    validator: (value) {
                      Uri uri = Uri.parse(value!);
                      if (!(uri.isAbsolute &&
                          uri.hasScheme &&
                          uri.hasAuthority)) {
                        return "Invalid URL";
                      }
                      return '';
                    },
                  ),
                  //FB form URL
                  UrlInput(
                    controller: fbUrlController,
                    icon: Icons.link_outlined,
                    hintText: 'FaceBook Form URL',
                    validator: (value) {
                      Uri uri = Uri.parse(value!);
                      if (!(uri.isAbsolute &&
                          uri.hasScheme &&
                          uri.hasAuthority)) {
                        return "Invalid URL";
                      }
                      return '';
                    },
                  ),
                  //Add Contacts
                  Padding(
                    padding: EdgeInsets.only(left: padding),
                    child: Text(
                      "Add Contacts",
                      style: TextStyle(
                        color: textColor,
                        fontSize: fontSize,
                      ),
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
                          child: CustomDropMenu(
                            items: moderators.map((Moderator moderator) {
                              return DropdownMenuItem<Moderator>(
                                value: moderator,
                                child: Text(moderator.name),
                              );
                            }).toList(),
                            value: selectedModerator,
                            onChanged: (Moderator? newValue) {
                              setState(() {
                                selectedModerator = newValue;
                              });
                            },
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
            );
          },
          body: _image == null
              ? Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Image.asset(
                      "assets/images/media.png",
                      width: width,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: width / 3),
                      child: SizedBox(
                        height: buttonHeight,
                        width: buttonWidth,
                        child: ElevatedButton(
                          onPressed: () => _getImage(),
                          child: const Text("Pick Image"),
                        ),
                      ),
                    ),
                  ],
                )
              : Align(
                  alignment: Alignment.topCenter,
                  child: GestureDetector(
                    onTap: () => _getImage(),
                    child: Image.file(
                      _image!,
                      width: width,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
