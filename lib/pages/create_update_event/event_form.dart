import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/models/models.dart';
import 'widgets/club_drop_down.dart';
import 'widgets/contacts_drop_down.dart';
import 'package:efficacy_admin/utils/utils.dart';
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
  DateTime selectedStartDate;
  DateTime selectedEndDate;
  TimeOfDay selectedStartTime;
  TimeOfDay selectedEndTime;
  final ClubModel? selectedClub;

  final void Function(UserModel?) onSelectedModeratorChanged;
  final void Function(DateTime) onSelectedStartDateChanged;
  final void Function(DateTime) onSelectedEndDateChanged;
  final void Function(TimeOfDay) onSelectedStartTimeChanged;
  final void Function(TimeOfDay) onSelectedEndTimeChanged;
  final void Function(ClubModel) onSelectedClubModelChanged;

  EventForm({
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
    required this.onSelectedStartDateChanged,
    required this.onSelectedEndDateChanged,
    required this.onSelectedStartTimeChanged,
    required this.onSelectedEndTimeChanged,
    required this.selectedStartDate,
    required this.selectedEndDate,
    required this.selectedStartTime,
    required this.selectedEndTime,
    required this.onSelectedModeratorChanged,
    this.selectedClub,
    required this.onSelectedClubModelChanged,
  });

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  //moderator declaration
  ClubModel? selectedClub;
  late DateTime selectedStartDate = widget.selectedStartDate;
  late DateTime selectedEndDate = widget.selectedEndDate;
  late TimeOfDay selectedStartTime = widget.selectedStartTime;
  late TimeOfDay selectedEndTime = widget.selectedEndTime;
  late UserModel? selectedModerator;

  Future<List<UserModel>> getModerators(ClubModel? club) async {
    if (club == null) return [];
    List<UserModel> moderators = [];
    Set<String> clubMembers = club.members.values.fold(
      <String>{},
      (allMembers, List<String> members) {
        allMembers.addAll(members);
        return allMembers;
      },
    );
    for (String userEmail in clubMembers) {
      List<UserModel> user = await UserController.get(email: userEmail).first;
      if (user.isNotEmpty) {
        moderators.add(user.first);
      }
    }
    return moderators;
  }

  Future<List<UserModel>> getContacts() async {
    List<UserModel> users = [];
    if (selectedClub != null) {
      selectedModerator = null;
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
        initialDate: pickerNumber == 1 ? selectedStartDate : selectedEndDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        builder: (BuildContext context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              iconButtonTheme: IconButtonThemeData(
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                  foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
            child: child!,
          );
        });

    if (picked != null) {
      setState(() {
        if (pickerNumber == 1) {
          widget.onSelectedStartDateChanged(picked);
          setState(() {
            selectedStartDate = picked;
          });
        } else {
          widget.onSelectedEndDateChanged(picked);
          setState(() {
            selectedEndDate = picked;
          });
        }
      });
    }
  }

  //function to get times
  Future<void> _selectTime(BuildContext context, int pickerNumber) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: pickerNumber == 1 ? selectedStartTime : selectedEndTime,
        builder: (BuildContext context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              iconButtonTheme: IconButtonThemeData(
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                  foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
            child: child!,
          );
        });

    if (picked != null) {
      setState(() {
        if (pickerNumber == 1) {
          widget.onSelectedStartTimeChanged(picked);
          setState(() {
            selectedStartTime = picked;
          });
        } else {
          widget.onSelectedEndTimeChanged(picked);
          setState(() {
            selectedEndTime = picked;
          });
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    selectedStartDate = widget.selectedStartDate;
    selectedEndDate = widget.selectedEndDate;
    selectedStartTime = widget.selectedStartTime;
    selectedEndTime = widget.selectedEndTime;
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: padding),
                    child: Text(
                      "Club ",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(fontSize: 20),
                    ),
                  ),
                  ClubDropDown(
                    items: UserController.clubWithModifyEventPermission,
                    value: selectedClub,
                    onChanged: (ClubModel? newClub) {
                      if (newClub != null) {
                        setState(() {
                          selectedClub = newClub;
                        });
                        widget.onSelectedClubModelChanged(newClub);
                      }
                    },
                  ),
                ].separate(10),
              ),
              //title
              CustomField(
                controller: widget.titleController,
                hintText: 'Event Title',
                icon: Icons.title,
                validator: (value) =>
                    Validator.nullAndEmptyCheck(value, "Title"),
              ),
              //short description
              CustomField(
                controller: widget.shortDescController,
                icon: Icons.format_align_right_rounded,
                validator: (value) =>
                    Validator.nullAndEmptyCheck(value, "Description"),
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
                selectedDate: selectedStartDate,
                selectedTime: selectedStartTime,
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
                selectedDate: selectedEndDate,
                selectedTime: selectedEndTime,
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
                    FutureBuilder(
                        future: getModerators(selectedClub),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            );
                          }
                          const SizedBox(width: 10);
                          List<UserModel> moderators = snapshot.data ?? [];
                          return Padding(
                            padding: EdgeInsets.only(left: padding),
                            child: (selectedClub != null)
                                ? ContactsDropDown(
                                    items: moderators,
                                    value: selectedModerator,
                                    onChanged: (UserModel? newModerator) {
                                      setState(() {
                                        selectedModerator = newModerator;
                                      });
                                      widget.onSelectedModeratorChanged(
                                          newModerator);
                                    },
                                  )
                                : const Text("No club selected"),
                          );
                        }),
                  ],
                ),
              ),
              //gap at the end
              SizedBox(height: endGap)
            ].separate(padding),
          ),
        ),
      ),
    );
  }
}
