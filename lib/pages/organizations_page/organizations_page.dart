import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:efficacy_admin/widgets/custom_drawer/custom_drawer.dart';
import 'package:flutter/material.dart';

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
      appBar: const CustomAppBar(),
      endDrawer: const CustomDrawer(),
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
                    buildInvitationsStream(height / 3),
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
                    buildClubsStream(height / 3),
                  ],
                ),
              ].separate(gap),
            ),
          ),
        ),
      )),
    );
  }
}
