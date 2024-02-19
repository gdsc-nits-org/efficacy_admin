import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/dialogs/loading_overlay/loading_overlay.dart';
import 'package:efficacy_admin/models/invitation/invitaion_model.dart';
import 'package:efficacy_admin/pages/club/club_page.dart';
import 'package:efficacy_admin/utils/local_database/local_database.dart';
import 'package:efficacy_admin/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:efficacy_admin/widgets/custom_drawer/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:efficacy_admin/utils/tutorials/tutorials.dart';
import 'widgets/clubs/clubs_stream.dart';
import 'widgets/invitations/invitations_stream.dart';

class OrganizationsPage extends StatefulWidget {
  const OrganizationsPage({super.key});

  static const String routeName = "/OrganizationsPage";

  @override
  State<OrganizationsPage> createState() => _OrganizationsPageState();
}

class _OrganizationsPageState extends State<OrganizationsPage> {
  late Stream<List<InvitationModel>> invitationsStream;
  Future<void> _refresh() async {
    await UserController.updateUserData();
    setState(() {
      invitationsStream = InvitationController.get(
        forceGet: true,
        recipientID: UserController.currentUser?.id,
      );
    });
  }

  // Check for guide
  bool isGuideRunning = false;

  // Global keys for guide
  GlobalKey invitationsKey = GlobalKey();
  GlobalKey clubsKey = GlobalKey();
  GlobalKey createClubKey = GlobalKey();

  List<TargetFocus> targets = [];

  @override
  void initState() {
    super.initState();
    invitationsStream = InvitationController.get(
      forceGet: true,
      recipientID: UserController.currentUser?.id,
    );
    if (LocalDatabase.getAndSetGuideStatus(LocalGuideCheck.organizations)) {
      isGuideRunning = true;
      Future.delayed(const Duration(seconds: 0), () {
        showOrganizationPageTutorial(
          context,
          invitationsKey,
          clubsKey,
          createClubKey,
          onFinish: () {
            setState(() {
              isGuideRunning = false;
            });
          },
          onSkip: () {
            setState(() {
              isGuideRunning = false;
            });
            // Returning true to allow skip
            return true;
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //screen height and width
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    //size constants
    double pad = width * 0.05;
    double gap = height * 0.02;

    return PopScope(
      canPop: !isGuideRunning,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
      },
      child: Scaffold(
        appBar: const CustomAppBar(title: "Organizations"),
        endDrawer: CustomDrawer(
          pageContext: context,
        ),
        floatingActionButton: FloatingActionButton(
          key: createClubKey,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ClubPage(
                  createMode: true, // Example parameter value
                  club: null,
                ),
              ),
            ).then((value) => showLoadingOverlay(
                parentContext: context,
                asyncTask: () async {
                  await _refresh();
                }));
          },
          heroTag: "Create club",
          tooltip: "Create a new club",
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(pad),
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Invitations",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: dark)),
                    const Divider(),
                    InvitationsStream(
                      key: invitationsKey,
                      maxHeight: height / 3,
                      onCompleteAction: () async {
                        await _refresh();
                      },
                      invitationStream: invitationsStream,
                    ),
                    const Divider(color: dark),
                    const Text(
                      "Clubs",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: dark),
                    ),
                    const Divider(),
                    ClubsStream(key: clubsKey, clubs: UserController.clubs),
                  ].separate(gap),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
