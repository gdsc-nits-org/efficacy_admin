import 'dart:typed_data';
import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/config/configurations/extensions/date_time_extension.dart';
import 'package:efficacy_admin/config/configurations/extensions/date_time_extension.dart';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/dialogs/loading_overlay/loading_overlay.dart';
import 'package:efficacy_admin/models/club/club_model.dart';
import 'package:efficacy_admin/models/event/event_model.dart';
import 'package:efficacy_admin/models/user/user_model.dart';
import 'event_form.dart';
import 'utils/create_event_utils.dart';
import 'widgets/upload_button.dart';
import 'package:efficacy_admin/widgets/snack_bar/error_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CreateUpdateEvent extends StatefulWidget {
  //route
  static const String routeName = '/CreateEventPage';

  final EventModel? event;
  final UserModel? moderator;
  final ClubModel? club;

  /// If [event] is passed it is assumed to be for edit
  ///
  /// [moderator] and [club] are expected to be passed if event is passed
  const CreateUpdateEvent({super.key, this.event, this.moderator, this.club});
  @override
  State<CreateUpdateEvent> createState() => _CreateUpdateEventState();
}

class _CreateUpdateEventState extends State<CreateUpdateEvent> {
  //form variables
  final _formKey = GlobalKey<FormState>();
  String? eventID;
  String? posterURL, posterPublicID;

  TextEditingController titleController = TextEditingController();
  TextEditingController shortDescController = TextEditingController();
  TextEditingController longDescController = TextEditingController();
  TextEditingController googleUrlController = TextEditingController();
  TextEditingController fbUrlController = TextEditingController();
  TextEditingController venueController = TextEditingController();

  UserModel? selectedModerator;
  ClubModel? selectedClub;

  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  Future<EventModel?> prepareEvent() async {
    if (selectedClub == null) {
      throw Exception("Please select a club");
    }
    DateTime start = selectedStartDate.toStartOfDay().add(
          Duration(
            hours: selectedStartTime.hour,
            minutes: selectedStartTime.minute,
          ),
        );
    DateTime end = selectedEndDate.toStartOfDay().add(
          Duration(
            hours: selectedEndTime.hour,
            minutes: selectedEndTime.minute,
          ),
        );
    if (start.millisecondsSinceEpoch >= end.millisecondsSinceEpoch) {
      throw Exception("Start time must be before end time");
    }

    EventModel? event;

    UploadInformation? posterInfo;
    if (_image != null) {
      posterInfo = await ImageController.uploadImage(
        img: _image!,
        eventName: titleController.text,
        clubName: selectedClub!.name,
        folder: ImageFolder.eventThumbnail,
      );
    } else if (posterURL != null && posterPublicID != null) {
      posterInfo = UploadInformation(url: posterURL, publicID: posterPublicID);
    } else {
      throw Exception("Please select a poster");
    }
    if (posterInfo.url == null || posterInfo.publicID == null) {
      throw Exception("Couldn't upload poster");
    }
    event = EventModel(
      id: eventID,
      posterURL: posterInfo.url!,
      posterPublicID: posterInfo.publicID!,
      title: titleController.text,
      shortDescription: shortDescController.text,
      longDescription:
          longDescController.text.isNotEmpty ? longDescController.text : null,
      startDate: start,
      endDate: end,
      registrationLink:
          googleUrlController.text.isNotEmpty ? googleUrlController.text : null,
      facebookPostURL:
          fbUrlController.text.isNotEmpty ? fbUrlController.text : null,
      venue: venueController.text,
      contacts: selectedModerator != null ? [selectedModerator!.email] : [],
      clubID: selectedClub!.id!,
    );
    return event;
  }

  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      eventID = widget.event!.id;
      posterURL = widget.event!.posterURL;
      posterPublicID = widget.event!.posterPublicID;
      titleController.text = widget.event!.title;
      shortDescController.text = widget.event!.shortDescription;
      longDescController.text = widget.event!.longDescription ?? "";
      googleUrlController.text = widget.event!.registrationLink ?? "";
      fbUrlController.text = widget.event!.facebookPostURL ?? "";
      venueController.text = widget.event!.venue;

      selectedStartDate = widget.event!.startDate;
      selectedEndDate = widget.event!.endDate;
      selectedStartTime = TimeOfDay.fromDateTime(selectedStartDate);
      selectedEndTime = TimeOfDay.fromDateTime(selectedEndDate);

      selectedModerator = widget.moderator;
      selectedClub = widget.club;
    }
  }

  //form validate function
  void _validateAndSync() {
    if (_formKey.currentState!.validate()) {
      EventModel? eventUpdated;
      FocusManager.instance.primaryFocus?.unfocus();
      showLoadingOverlay(
        parentContext: context,
        asyncTask: () async {
          EventModel? event = await prepareEvent();
          if (event != null) {
            if (widget.event == null) {
              eventUpdated = await EventController.create(event);
            } else {
              eventUpdated = await EventController.update(event);
            }
          } else {
            throw Exception("Couldn't create event");
          }
        },
        onCompleted: () {
          if (eventUpdated != null) {
            Navigator.pop(context, eventUpdated);
          }
        },
      );
    } else {
      showSnackBar(
        context,
        "Please enter the required values.",
      );
    }
  }

  //image variable
  Uint8List? _image;

  //function to get image from gallery
  Future<void> _getImage() async {
    showLoadingOverlay(
      parentContext: context,
      asyncTask: () async {
        Uint8List? temp = await ImageController.compressedImage(
          source: ImageSource.gallery,
          maxSize: 1024 * 1024,
          context: context,
        );
        setState(() {
          _image = temp;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    getSize(context);
    return Scaffold(
      floatingActionButton: UploadButton(onPressed: _validateAndSync),
      body: SafeArea(
        child: Stack(
          children: [
            SlidingUpPanel(
              padding: const EdgeInsets.only(top: 30),
              maxHeight: height,
              minHeight: height * .60,
              borderRadius: BorderRadius.circular(30),
              header: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: width * 0.33),
                  Container(
                    height: 3,
                    width: width * 0.35,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
              panelBuilder: (sc) => EventForm(
                formKey: _formKey,
                scrollController: sc,
                titleController: titleController,
                shortDescController: shortDescController,
                longDescController: longDescController,
                googleUrlController: googleUrlController,
                fbUrlController: fbUrlController,
                venueController: venueController,
                selectedStartDate: selectedStartDate,
                selectedClub: selectedClub,
                onSelectedClubModelChanged: (ClubModel clubModel) {
                  setState(() {
                    selectedClub = clubModel;
                  });
                },
                onSelectedStartDateChanged: (DateTime newDate) {
                  setState(() {
                    selectedStartDate = newDate;
                  });
                },
                selectedEndDate: selectedEndDate,
                onSelectedEndDateChanged: (DateTime newDate) {
                  setState(() {
                    selectedEndDate = newDate;
                  });
                },
                selectedStartTime: selectedStartTime,
                onSelectedStartTimeChanged: (TimeOfDay newTime) {
                  setState(() {
                    selectedStartTime = newTime;
                  });
                },
                selectedEndTime: selectedEndTime,
                onSelectedEndTimeChanged: (TimeOfDay newTime) {
                  setState(() {
                    selectedEndTime = newTime;
                  });
                },
                selectedModerator: selectedModerator,
                onSelectedModeratorChanged: (UserModel? newModerator) {
                  setState(() {
                    selectedModerator = newModerator;
                  });
                },
              ),
              body: _image == null
                  ? posterURL == null
                      ? DefaultImagePicker(onPressed: _getImage)
                      : Align(
                          alignment: Alignment.topCenter,
                          child: GestureDetector(
                            onTap: () => _getImage(),
                            child: Image.network(
                              posterURL!,
                              height: height * 0.4,
                              width: width,
                              fit: BoxFit.fitHeight,
                              errorBuilder: (BuildContext context, _, __) {
                                return DefaultImagePicker(onPressed: _getImage);
                              },
                            ),
                          ),
                        )
                  : Align(
                      alignment: Alignment.topCenter,
                      child: GestureDetector(
                        onTap: () => _getImage(),
                        child: Image.memory(
                          _image!,
                          height: height * 0.4,
                          width: width,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
            ),
            Positioned(
              left: 15,
              top: 35,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Align(
                  alignment: Alignment.topLeft,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: dark,
                    child: Icon(
                      Icons.close,
                      size: height * 0.035,
                      color: light,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DefaultImagePicker extends StatelessWidget {
  final void Function() onPressed;

  const DefaultImagePicker({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Image.asset(
          Assets.mediaImgPath,
          height: height * 0.4,
          width: width,
          fit: BoxFit.fitHeight,
        ),
        Padding(
          padding: EdgeInsets.only(top: width / 2),
          child: SizedBox(
            height: buttonHeight,
            width: buttonWidth,
            child: ElevatedButton(
              onPressed: onPressed,
              child: const Text("Pick Image"),
            ),
          ),
        ),
      ],
    );
  }
}
