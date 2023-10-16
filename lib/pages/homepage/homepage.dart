import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/services/image/image_controller.dart';
import 'package:efficacy_admin/models/event/event_model.dart';
import 'package:efficacy_admin/pages/homepage/widgets/events/event_list.dart';
import 'package:efficacy_admin/pages/homepage/widgets/events/event_viewer.dart';
import 'package:efficacy_admin/pages/homepage/widgets/tab_navigation/tab_view.dart';
import 'package:efficacy_admin/widgets/custom_app_bar/custom_app_bar.dart';
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
    return Scaffold(
      appBar: const CustomAppBar(),
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
