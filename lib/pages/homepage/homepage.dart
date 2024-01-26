import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/models/event/event_model.dart';
import 'package:efficacy_admin/models/models.dart';
import 'package:efficacy_admin/pages/homepage/widgets/events/events_showcase.dart';
import 'package:efficacy_admin/pages/homepage/widgets/tab_navigation/tab_view.dart';
import 'package:efficacy_admin/utils/local_database/local_database.dart';
import 'package:efficacy_admin/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:efficacy_admin/widgets/custom_drawer/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../widgets/coach_mark_desc/coach_mark_desc.dart';

class Homepage extends StatefulWidget {
  static const String routeName = "/homePage";
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentTabIndex = 0;

  // Global keys for guide
  GlobalKey drawerKey = GlobalKey();
  GlobalKey createEventKey = GlobalKey();
  GlobalKey listEventsKey = GlobalKey();
  GlobalKey feedKey = GlobalKey();

  TutorialCoachMark? tutorialCoachMark;
  List<TargetFocus> targets = [];

  @override
  void initState() {
    // To view guide everytime uncomment the next line
    // LocalDatabase.resetGuideCheckpoint();
    if (LocalDatabase.getGuideStatus(LocalGuideCheck.home)) {
      Future.delayed(const Duration(seconds: 1), () {
        _showTutorial();
      });
    }
    super.initState();
  }

  void _showTutorial() {
    _initTarget();
    // print(targets);
    tutorialCoachMark = TutorialCoachMark(
      hideSkip: true,
      useSafeArea: true,
      targets: targets, // List<TargetFocus>
    )..show(context: context);
  }

  void _initTarget() {
    targets = [
      TargetFocus(
        identify: "List of Events",
        keyTarget: listEventsKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                heading: "List of events",
                text:
                    "This shows the list of events categorized into upcoming,ongoing and completed events.",
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      TargetFocus(
        identify: "Drawer",
        keyTarget: drawerKey,
        contents: [
          TargetContent(
            // align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                heading: "Menu",
                text: "Click to navigate between pages and see more options.",
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      TargetFocus(
        identify: "Feed",
        keyTarget: feedKey,
        contents: [
          TargetContent(
            customPosition: CustomTargetContentPosition(top: 18),
            align: ContentAlign.custom,
            builder: (context, controller) {
              return CoachmarkDesc(
                heading: "Feed",
                text:
                    "This is where you can view different events in a category. Pull down to refresh the feed.",
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          ),
        ],
      ),
      TargetFocus(
        identify: "Create Event",
        keyTarget: createEventKey,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return CoachmarkDesc(
                heading: "Create Event",
                text: "This is where you can create new event.",
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          ),
        ],
      ),
    ];
  }

  void navigator(EventStatus buttonMessage) {
    setState(() {
      currentTabIndex = EventStatus.values.indexOf(buttonMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(drawerKey: drawerKey, title: "Home"),
      endDrawer: const CustomDrawer(),
      body: Column(
        children: [
          TabView(
            key: listEventsKey,
            currentTabIndex: currentTabIndex,
            navigator: navigator,
          ),
          Expanded(
            key: feedKey,
            child: EventsShowcasePage(
              createEventKey: createEventKey,
              eventStatus: currentTabIndex == 0
                  ? EventStatus.Upcoming
                  : currentTabIndex == 1
                      ? EventStatus.Ongoing
                      : EventStatus.Completed,
            ),
          ),
          // Visibility(
          //   visible: currentTabIndex == 0 &&
          //       UserController.currentUser != null &&
          //       UserController.currentUser!.position.isNotEmpty,
          //   child: Padding(
          //     padding: const EdgeInsets.only(bottom: 12.0, right: 12.0),
          //     child: Align(
          //       alignment: Alignment.centerRight,
          //       child: FloatingActionButton(
          //         onPressed: () async {
          //           Navigator.pushNamed(context, CreateEvent.routeName);
          //         }, //define add event function here
          //         child: const Icon(Icons.add),
          //       ),
          //     ),
          //   ),
          // )
        ].separate(26),
      ),
    );
  }
}
