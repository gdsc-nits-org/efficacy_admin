import 'dart:typed_data';
import 'package:efficacy_admin/config/config.dart';
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
  TextEditingController venueController = TextEditingController();

  UserModel? selectedModerator;
  ClubModel? selectedClub;

  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  TimeOfDay selectedTime1 = TimeOfDay.now();
  TimeOfDay selectedTime2 = TimeOfDay.now();

  //form validate function
  void _validateForm() {
    if (_formKey.currentState!.validate()) {
      //validation logic
      EventModel event = EventModel(
        posterURL: _image.toString(),
        title: titleController.text,
        shortDescription: shortDescController.text,
        longDescription:
            longDescController.text.isNotEmpty ? longDescController.text : null,
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        registrationLink: googleUrlController.text,
        facebookPostURL:
            fbUrlController.text.isNotEmpty ? fbUrlController.text : null,
        venue: venueController.text,
        contacts: selectedModerator != null ? [selectedModerator!.email] : [],
        clubID: selectedClub!.id!,
      );
      showLoadingOverlay(context: context, asyncTask: () async{
        await EventController.create(event);
      },);
    } else {
      showErrorSnackBar(
          context, "Upload failed. Please enter the required values.");
    }
  }

  //image variable
  Uint8List? _image;

  //function to get image from gallery
  Future<void> _getImage() async {
    Uint8List? temp = await ImageController.compressedImage(
      source: ImageSource.gallery,
      maxSize: 1024 * 1024,
      context: context,
    );
    setState(() {
      _image = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    getSize(context);

    return Stack(children: [
      Scaffold(
        floatingActionButton: UploadButton(onPressed: _validateForm),
        body: SafeArea(
          child: SlidingUpPanel(
            padding: const EdgeInsets.only(top: 30),
            maxHeight: height,
            minHeight: height * .70,
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
              selectedDate1: selectedDate1,
              selectedClub: selectedClub,
              onSelectedClubModelChanged: (ClubModel clubModel) {
                setState(() {
                  selectedClub = clubModel;
                });
              },
              onSelectedDate1Changed: (DateTime newDate) {
                setState(() {
                  selectedDate1 = newDate;
                });
              },
              selectedDate2: selectedDate2,
              onSelectedDate2Changed: (DateTime newDate) {
                setState(() {
                  selectedDate2 = newDate;
                });
              },
              selectedTime1: selectedTime1,
              onSelectedTime1Changed: (TimeOfDay newTime) {
                setState(() {
                  selectedTime1 = newTime;
                });
              },
              selectedTime2: selectedTime2,
              onSelectedTime2Changed: (TimeOfDay newTime) {
                setState(() {
                  selectedTime2 = newTime;
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
                      child: Image.memory(
                        _image!,
                        width: width,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
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
    ]);
  }
}
