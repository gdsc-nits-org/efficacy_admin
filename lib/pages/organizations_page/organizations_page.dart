import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/models/invitation/invitaion_model.dart';
import 'package:efficacy_admin/pages/create_edit_club/create_edit_club_page.dart';
import 'package:efficacy_admin/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:efficacy_admin/widgets/custom_drawer/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'widgets/clubs/clubs_stream.dart';
import 'widgets/invitations/invitations_stream.dart';

class OrganizationsPage extends StatefulWidget {
  const OrganizationsPage({super.key});
  static const String routeName = "/OrganizationsPage";

  @override
  State<OrganizationsPage> createState() => _OrganizationsPageState();
}

class _OrganizationsPageState extends State<OrganizationsPage> {
  @override
  Widget build(BuildContext context) {
    //screen height and width
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    //size constants
    double pad = width * 0.05;
    double gap = height * 0.02;

    return Scaffold(
      appBar: const CustomAppBar(title: "Organizations"),
      endDrawer: const CustomDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.pushNamed(context, CreateEditClub.routeName);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateEditClub(
                createMode: true, // Example parameter value
                club: null,
              ),
            ),
          ).then((value) => setState(() {}));
        },
        heroTag: "Create club",
        tooltip: "Create a new club",
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(pad),
          child: SingleChildScrollView(
            child: SizedBox(
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Invitations",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: dark)),
                      const Divider(),
                      InvitationsStream(maxHeight: height / 3),
                    ],
                  ),
                  const Divider(color: dark),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Clubs",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: dark)),
                      const Divider(),
                      ClubsStream(maxHeight: height / 3),
                    ],
                  ),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       InvitationController.create(InvitationModel(
                  //           clubPositionID: "6575c5edfcd27f194e6ed6b4",
                  //           senderID: "653e0b6c1bde28c6db2d4c5a",
                  //           recipientID: UserController.currentUser!.id!));
                  //     },
                  //     child: Text("Jaldi"))
                ].separate(gap),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
