import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/models/models.dart';
import 'package:efficacy_admin/pages/create_event/widgets/club_drop_down.dart';
import 'package:efficacy_admin/pages/create_event/widgets/contacts_drop_down.dart';
import 'package:efficacy_admin/utils/utils.dart';
import 'package:efficacy_admin/widgets/custom_drop_down/custom_drop_down.dart';
import 'utils/create_event_utils.dart';
import 'widgets/custom_text_field.dart';
import 'widgets/date_time_picker.dart';
import 'widgets/url_input.dart';
import 'package:flutter/material.dart';

class EventForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final ScrollController scrollController;
  final TextEditingController titleController;
  final TextEditingController shortDescController;
  final TextEditingController longDescController;
  final TextEditingController googleUrlController;
  final TextEditingController fbUrlController;
  final TextEditingController venueController;

  final UserModel? selectedModerator;
  final DateTime selectedDate1;
  final DateTime selectedDate2;
  final TimeOfDay selectedTime1;
  final TimeOfDay selectedTime2;
  final ClubModel? selectedClub;

  final void Function(UserModel?) onSelectedModeratorChanged;
  final void Function(DateTime) onSelectedDate1Changed;
  final void Function(DateTime) onSelectedDate2Changed;
  final void Function(TimeOfDay) onSelectedTime1Changed;
  final void Function(TimeOfDay) onSelectedTime2Changed;
  final void Function(ClubModel) onSelectedClubModelChanged;

  const EventForm({
    super.key,
    required this.formKey,
    required this.scrollController,
    this.selectedModerator,
    required this.titleController,
    required this.shortDescController,
    required this.longDescController,
    required this.googleUrlController,
    required this.fbUrlController,
    required this.venueController,
    required this.onSelectedDate1Changed,
    required this.onSelectedDate2Changed,
    required this.onSelectedTime1Changed,
    required this.onSelectedTime2Changed,
    required this.selectedDate1,
    required this.selectedDate2,
    required this.selectedTime1,
    required this.selectedTime2,
    required this.onSelectedModeratorChanged,
    this.selectedClub,
    required this.onSelectedClubModelChanged,
  });

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  //moderator declaration
  List<UserModel> moderators = [];
  ClubModel? selectedClub;
  late DateTime selectedDate1;
  late DateTime selectedDate2;
  late TimeOfDay selectedTime1;
  late TimeOfDay selectedTime2;
  late UserModel? selectedModerator;

  Future<List<UserModel>> getContacts() async {
    List<UserModel> users = [];
    if (selectedClub != null) {
      for (MapEntry<String, List<String>> position
          in selectedClub!.members.entries) {
        for (String userMail in position.value) {
          List<UserModel> user =
              await UserController.get(email: userMail).first;
          if (user.isNotEmpty) {
            users.add(user.first);
          }
        }
      }
    }
    return users;
  }

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
          widget.onSelectedDate1Changed(picked);
        } else {
          widget.onSelectedDate2Changed(picked);
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
          widget.onSelectedTime1Changed(picked);
        } else {
          widget.onSelectedTime2Changed(picked);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    selectedDate1 = widget.selectedDate1;
    selectedDate2 = widget.selectedDate2;
    selectedTime1 = widget.selectedTime1;
    selectedTime2 = widget.selectedTime2;
    selectedModerator = widget.selectedModerator;
    selectedClub = widget.selectedClub;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 25.0),
      child: Form(
        key: widget.formKey,
        child: SingleChildScrollView(
          controller: widget.scrollController,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: padding),
                    child: Text(
                      "Club ",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  ClubDropDown(
                    items: UserController.clubs,
                    value: selectedClub,
                    onChanged: (ClubModel? newClub) {
                      if (newClub != null) {
                        widget.onSelectedClubModelChanged(newClub);
                      }
                    },
                  ),
                ].separate(5),
              ),
              //title
              CustomField(
                controller: widget.titleController,
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
                controller: widget.shortDescController,
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
                controller: widget.longDescController,
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
                controller: widget.venueController,
                maxLines: 1,
              ),
              //google form
              UrlInput(
                enabled: true,
                controller: widget.googleUrlController,
                icon: Icons.link_outlined,
                hintText: 'Google Form URL',
                validator: Validator.isValidURL,
              ),
              // //FB form URL
              UrlInput(
                enabled: true,
                controller: widget.fbUrlController,
                icon: Icons.link_outlined,
                hintText: 'FaceBook Link',
                validator: Validator.isValidURL,
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
                      color: const Color.fromARGB(137, 93, 77, 77),
                      size: iconSize,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: padding),
                      child: ContactsDropDown(
                        items: moderators,
                        value: selectedModerator,
                        onChanged: (UserModel? newModerator) {
                          setState(() {
                            widget.onSelectedModeratorChanged(newModerator);
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
