import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/dialogs/loading_overlay/loading_overlay.dart';
import 'package:efficacy_admin/pages/pages.dart';
import 'package:efficacy_admin/utils/local_database/local_database.dart';
import 'package:efficacy_admin/widgets/custom_drawer/utils/get_feedback_data.dart';
import 'package:efficacy_admin/widgets/profile_image_viewer/profile_image_viewer.dart';
import 'package:efficacy_admin/widgets/snack_bar/error_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/services.dart';

import 'package:efficacy_admin/utils/tutorials/tutorials.dart';

class CustomDrawer extends StatefulWidget {
  final BuildContext pageContext;
  const CustomDrawer({super.key, required this.pageContext});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late bool pendingInvites = false;

  Future<void> init() async {
    pendingInvites = await InvitationController.anyPendingInvitation();
    if (pendingInvites) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  OnFeedbackCallback sendFeedback() {
    return (UserFeedback feedback) async {
      await showLoadingOverlay(
        context: widget.pageContext,
        asyncTask: () async {
          Uint8List data = await getFeedBackData(feedback);
          DateTime now = DateTime.now();
          await ImageController.uploadImage(
            img: data,
            folder: ImageFolder.feedback,
            name: now.toIso8601String(),
          );
          showSnackBar(widget.pageContext,
              "Your feedback was shared, Thank you for your feedback.");
        },
      );
    };
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
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
            leading: Icon(
              Icons.home,
              color: routeName == "/homePage"
                  ? Theme.of(context).scaffoldBackgroundColor
                  : dark,
            ),
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
            leading: Icon(
              Icons.people,
              color: routeName == "/OrganizationsPage"
                  ? Theme.of(context).scaffoldBackgroundColor
                  : dark,
            ),
            title: const Text('Organizations'),
            trailing: pendingInvites ? const Text("NEW") : null,
            selected: routeName == "/OrganizationsPage",
            selectedColor: light,
            selectedTileColor: dark,
            onTap: () {
              setState(() {
                pendingInvites = false;
              });
              // Close the drawer
              Navigator.pop(context);
              // Navigate to Organizations page
              Navigator.of(context).pushNamed(
                OrganizationsPage.routeName,
              );
            },
          ),
          ListTile(
            leading: Icon(
              CupertinoIcons.envelope,
              color: routeName == "/invitePage"
                  ? Theme.of(context).scaffoldBackgroundColor
                  : dark,
            ),
            title: const Text('Invite Requests'),
            selected: routeName == "/invitePage",
            selectedColor: light,
            selectedTileColor: dark,
            onTap: () {
              // Close the drawer
              Navigator.pop(context);
              // Navigate to invite page
              Navigator.of(context).pushNamed(
                InvitePage.routeName,
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.bug_report,
              color: dark,
            ),
            title: const Text('Report Bug'),
            onTap: () async {
              if (LocalDatabase.getAndSetGuideStatus(
                  LocalGuideCheck.reportBug)) {
                await showReportBugTutorial(context);
              }

              // Close the drawer
              Navigator.pop(context);
              if (widget.pageContext.mounted) {
                // Then send feedback
                BetterFeedback.of(widget.pageContext).show(sendFeedback());
              }
            },
          ),
          ListTile(
            leading: Icon(
              Icons.developer_mode,
              color: routeName == "/developersPage"
                  ? Theme.of(context).scaffoldBackgroundColor
                  : dark,
            ),
            title: const Text('Developers'),
            selected: routeName == "/developersPage",
            selectedColor: light,
            selectedTileColor: dark,
            onTap: () {
              // Close the drawer
              Navigator.pop(context);
              // Navigate to developers page
              Navigator.of(context).pushNamed(
                DevelopersPage.routeName,
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: const Text(
              'Log out',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () async {
              // Close the drawer
              Navigator.pop(context);
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
