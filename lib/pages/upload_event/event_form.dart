import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/pages/upload_event/utils/create_event_utils.dart';
import 'package:efficacy_admin/pages/upload_event/widgets/custom_drop_down.dart';
import 'package:efficacy_admin/pages/upload_event/widgets/custom_text_field.dart';
import 'package:efficacy_admin/pages/upload_event/widgets/date_time_picker.dart';
import 'package:efficacy_admin/pages/upload_event/widgets/url_input.dart';
import 'package:flutter/material.dart';

class EventForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const EventForm({
    super.key,
    required this.formKey,
  });

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  //moderator declaration
  List<Moderator> moderators = [
    Moderator('John Doe'),
    Moderator('Jane Doe'),
    Moderator('Jim Doe'),
  ];

  //date time variables

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 25.0),
      child: Form(
        key: widget.formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomField(
                controller: clubIDController,
                hintText: 'Club ID',
                icon: Icons.group,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Club ID cannot be empty';
                  }
                  return null;
                },
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
                validator: (value) => null,
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
                    color: textColor,
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
              CustomField(
                hintText: 'Venue',
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Venue cannot be empty";
                  }
                  return null;
                },
                icon: Icons.house,
                controller: venueController,
                maxLines: 1,
              ),
              //google form
              UrlInput(
                controller: googleUrlController,
                icon: Icons.link_outlined,
                hintText: 'Google Form URL',
                validator: (value) {
                  Uri uri = Uri.parse(value!);
                  if (!(uri.isAbsolute && uri.hasScheme && uri.hasAuthority)) {
                    return "Invalid URL";
                  }
                  return '';
                },
              ),
              //FB form URL
              UrlInput(
                controller: fbUrlController,
                icon: Icons.link_outlined,
                hintText: 'FaceBook Link',
                validator: (value) {
                  Uri uri = Uri.parse(value!);
                  if (value.isNotEmpty) {
                    if (!(uri.isAbsolute &&
                        uri.hasScheme &&
                        uri.hasAuthority)) {
                      return "Invalid URL";
                    }
                    return '';
                  }
                  return null;
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
        ),
      ),
    );
  }
}
