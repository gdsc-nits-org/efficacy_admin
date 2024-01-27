import 'dart:io';

import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/pages/pages.dart';
import 'package:efficacy_admin/utils/local_database/local_database.dart';
import 'package:efficacy_admin/widgets/coach_mark_desc/coach_mark_desc.dart';
import 'package:efficacy_admin/widgets/profile_image_viewer/profile_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late bool pendingInvites = false;

  // Global keys for guide
  GlobalKey profileKey = GlobalKey();
  GlobalKey homeKey = GlobalKey();
  GlobalKey orgKey = GlobalKey();
  GlobalKey logoutKey = GlobalKey();

  TutorialCoachMark? tutorialCoachMark;
  List<TargetFocus> targets = [];

  Future<void> init() async {
    pendingInvites = await InvitationController.anyPendingInvitation();
    if (pendingInvites) {
      setState(() {});
    }
  }

  @override
  void initState() {
    init();
    if (LocalDatabase.getGuideStatus(LocalGuideCheck.drawer)) {
      Future.delayed(const Duration(seconds: 0), () {
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
        identify: "Profile",
        keyTarget: profileKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                heading: "Profile",
                text: "Click here to view your profile.",
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
        identify: "Home",
        keyTarget: homeKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                heading: "Home page",
                text: "Click here to navigate to home page.",
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
        identify: "Organization",
        keyTarget: orgKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                heading: "Organization page",
                text: "Click here to navigate to organization page.",
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
        identify: "Logout",
        keyTarget: logoutKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                heading: "Log out",
                text: "Click here to log out from your account.",
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
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    //size constants
    double gap = height * 0.02;

    // Get current route name
    var route = ModalRoute.of(context);
    String? routeName;

    if (route != null) {
      // debugPrint(route.settings.name);
      routeName = route.settings.name;
    }
    return Drawer(
      backgroundColor: light,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            key: profileKey,
            height: height * 0.33,
            decoration: const BoxDecoration(color: dark),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ProfilePage.routeName);
              },
              child: AbsorbPointer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ProfileImageViewer(
                      enabled: false,
                      imagePath: UserController.currentUser?.userPhoto,
                    ),
                    SizedBox(
                      width: 100,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: light,
                          foregroundColor: dark,
                        ),
                        child: const Text("Profile"),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ].separate(10),
                ),
              ),
            ),
          ),
          ListTile(
            key: homeKey,
            title: const Text('Home'),
            selected: routeName == "/homePage",
            selectedColor: light,
            selectedTileColor: dark,
            onTap: () {
              // Close the drawer
              Navigator.pop(context);
              // Navigate to Home page
              Navigator.of(context).pushNamed(
                Homepage.routeName,
              );
            },
          ),
          ListTile(
            key: orgKey,
            title: const Text('Organizations'),
            trailing: pendingInvites ? const Text("NEW") : null,
            selected: routeName == "/OrganizationsPage",
            selectedColor: light,
            selectedTileColor: dark,
            onTap: () {
              // Close the drawer
              Navigator.pop(context);
              // Navigate to Organizations page
              Navigator.of(context).pushNamed(
                OrganizationsPage.routeName,
              );
            },
          ),
          ListTile(
            key: logoutKey,
            title: const Text('Log out'),
            onTap: () async {
              await UserController.logOut();

              if (mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  LoginPage.routeName,
                  (route) => false,
                );
              }
            },
          ),
        ].separate(gap),
      ),
    );
  }
}
