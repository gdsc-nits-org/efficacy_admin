import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/models/club_position/club_position_model.dart';
import 'package:efficacy_admin/models/invitation/invitaion_model.dart';
import 'package:efficacy_admin/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:efficacy_admin/widgets/custom_drawer/custom_drawer.dart';
import 'package:efficacy_admin/widgets/snack_bar/error_snack_bar.dart';
import 'package:flutter/material.dart';

class OrganizationsPage extends StatefulWidget {
  const OrganizationsPage({super.key});
  static const String routeName = "/OrganizationsPage";

  @override
  State<OrganizationsPage> createState() => _OrganizationsPageState();
}

Widget _buildInvitationItem(String clubName, String clubPosition) {
  return Container(
    padding: const EdgeInsets.all(5.0),
    decoration: const BoxDecoration(
        border: BorderDirectional(bottom: BorderSide(color: shadow))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(clubName, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(clubPosition),
          ],
        ),
        Row(
          children: [
            Tooltip(
              message: "Accept",
              child: IconButton(
                onPressed: () {
                  // Handle accept invitation
                  // InvitationController.acceptInvitation();
                },
                icon: const Icon(
                  Icons.check,
                  color: Colors.green,
                ),
              ),
            ),
            Tooltip(
              message: "Reject",
              child: IconButton(
                onPressed: () {
                  // Handle reject invitation
                  //InvitationController.rejectInvitation(invitation);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildInvitationsStream(double maxHeight) {
  return ConstrainedBox(
    constraints: BoxConstraints(maxHeight: maxHeight),
    child: StreamBuilder<List<InvitationModel>>(
        stream: InvitationController.get(
          senderID: UserController.currentUser?.id,
        ),
        initialData: const [],
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final invitations = snapshot.data;
              if (invitations!.isNotEmpty) {
                return SingleChildScrollView(
                  child: Column(
                    children: invitations.map((invitation) {
                      return _buildInvitationItem(
                        invitation.recipientID,
                        invitation.clubPositionID,
                      );
                    }).toList(),
                  ),
                );
              } else if (snapshot.hasError) {
                showErrorSnackBar(context, 'Error: ${snapshot.error}');
                throw Exception('Error: ${snapshot.error}');
              } else {
                return const Text("No invitations");
              }
            } else {
              // Found to run when no user is logged in
              showErrorSnackBar(context, "Please login");
              throw Exception("User not logged in");
            }
          } else {
            // Works for all connection state but the one encountered here is ConnectionState.waiting
            return const CircularProgressIndicator();
          }
        }),
  );
}

Widget _buildClubsStream(double maxHeight) {
  return StreamBuilder(
    stream: ClubPositionController.get(clubID: UserController.currentUser?.id),
    initialData: const [ClubPositionModel(clubID: "GDSC", position: "Lead")],
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // Loading state
        return const CircularProgressIndicator();
      } else if (snapshot.hasError) {
        // Error state
        showErrorSnackBar(context, 'Error: ${snapshot.error}');
        return Text("Error: ${snapshot.error}");
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        // Empty data state
        return const Text('No club positions available.');
      } else {
        // Data available
        final clubPositions = snapshot.data!;
        return ListView.builder(
          itemCount: clubPositions.length,
          itemBuilder: (context, index) {
            final clubPosition = clubPositions[index];
            return ListTile(
              selectedTileColor: dark,
              selectedColor: light,
              selected: false,
              textColor: dark,
              tileColor: light,
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {},
              ),
              title: Text('Club: ${clubPosition.clubID}'),
              subtitle: Text('Position: ${clubPosition.position}'),
            );
          },
        );
      }
    },
  );
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
                    _buildInvitationsStream(height / 3),
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
                    _buildClubsStream(height / 3),
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
