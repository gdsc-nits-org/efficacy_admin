import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/controllers/services/image/image_controller.dart';
import 'package:efficacy_admin/models/event/event_model.dart';
import 'package:efficacy_admin/models/models.dart';
import 'package:efficacy_admin/pages/homepage/widgets/events/event_list.dart';
import 'package:efficacy_admin/pages/homepage/widgets/events/event_viewer.dart';
import 'package:efficacy_admin/pages/homepage/widgets/tab_navigation/tab_view.dart';
import 'package:efficacy_admin/utils/data_sync/foreground_service.dart';
import 'package:efficacy_admin/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:efficacy_admin/widgets/custom_drawer/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Homepage extends StatefulWidget {
  static const String routeName = "/homePage";
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentTabIndex = 0;

  void navigator(Status buttonMessage) {
    setState(() {
      currentTabIndex = Status.values.indexOf(buttonMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    // ClubPositionController.create(ClubPositionModel(
    //     clubID: "652c3bec1c506f70837a41f3", position: "position"));
    // UserController.create(
    //   const UserModel(
    //     name: "1",
    //     password: '123',
    //     email: "raj3@mail.co",
    //     scholarID: "2112035",
    //     branch: Branch.CSE,
    //     degree: Degree.BTech,
    //     position: ["65360e2b1cc773a82d995d82"],
    //   ),
    // );
    // EventController.create(
    //   EventModel(
    //     posterURL: "posterURL",
    //     title: "title",
    //     shortDescription: "shortDescription",
    //     startDate: DateTime.now(),
    //     endDate: DateTime.now(),
    //     registrationLink: "registrationLink",
    //     venue: "venue",
    //     contacts: [],
    //     clubID: "652c3bec1c506f70837a41f3",
    //   ),
    // );
    ForegroundService.startDataSync();

    return Scaffold(
      appBar: const CustomAppBar(),
      endDrawer: const CustomDrawer(),
      body: Column(
        children: [
          TabView(
            currentTabIndex: currentTabIndex,
            navigator: navigator,
          ),
          EventViewer(
            typeIndex: currentTabIndex,
            events: eventList,
          ),
          Visibility(
            visible: currentTabIndex == 0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0, right: 12.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: FloatingActionButton(
                  onPressed: () async {
                    XFile? file = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (file != null) {
                      ImageController.uploadImage(
                          img: await file.readAsBytes(),
                          clubName: "GDSC",
                          eventName: "Flutter");
                    }
                  }, //define add event function here
                  child: const Icon(Icons.add),
                ),
              ),
            ),
          )
        ].separate(26),
      ),
    );
  }
}
