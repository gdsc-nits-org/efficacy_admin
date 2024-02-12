// import 'package:efficacy_admin/controllers/controllers.dart';
// import 'package:efficacy_admin/models/invitation/invitaion_model.dart';
// import 'package:efficacy_admin/pages/invite_requests/widgets/invite_item.dart';
// import 'package:efficacy_admin/widgets/custom_app_bar/custom_app_bar.dart';
// import 'package:efficacy_admin/widgets/custom_drawer/custom_drawer.dart';
// import 'package:flutter/material.dart';

// class InvitePage extends StatefulWidget {
//   const InvitePage({super.key});

//   static const String routeName = "/invitePage";

//   @override
//   State<InvitePage> createState() => _InvitePageState();
// }

// class _InvitePageState extends State<InvitePage> {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       appBar: const CustomAppBar(
//         title: "Invite Requests",
//       ),
//       endDrawer: CustomDrawer(
//         pageContext: context,
//       ),
//       body: StreamBuilder<List<InvitationModel>>(
//         stream:
//             InvitationController.get(senderID: UserController.currentUser!.id),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return const Text("An unexpected error occured");
//           } else {
//             if (snapshot.hasData) {
//               List<InvitationModel>? invitations = snapshot.data ?? [];
//               return ListView.builder(
//                 itemCount: invitations.length,
//                 itemBuilder: (context, index) {
//                   InviteItem(
//                       clubPositionID: invitations[index].clubPositionID,
//                       receiverID: invitations[index].recipientID,
//                       invitation: invitations[index]);
//                 },
//               );
//             }
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/services/invitation/invitation_controller.dart';
import 'package:efficacy_admin/controllers/services/user/user_controller.dart';
import 'package:efficacy_admin/models/invitation/invitaion_model.dart';
import 'package:efficacy_admin/pages/organizations_page/widgets/invitations/invitations_item.dart';
import 'package:efficacy_admin/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:efficacy_admin/widgets/custom_drawer/custom_drawer.dart';
import 'package:efficacy_admin/widgets/snack_bar/error_snack_bar.dart';
import 'package:flutter/material.dart';

import 'widgets/invite_item.dart';

class InvitePage extends StatefulWidget {
  // final double maxHeight;
  // final VoidCallback onCompleteAction;
  // final Stream<List<InvitationModel>> invitationStream;

  const InvitePage({
    super.key,
    // required this.maxHeight,
    // required this.onCompleteAction,
    // required this.invitationStream,
  });
  static const String routeName = "/invitePage";

  @override
  State<InvitePage> createState() => InvitePageState();
}

class InvitePageState extends State<InvitePage> {
  List<InvitationModel> invitations = [];
  Future<void> _refresh() async {
    List<InvitationModel> latestInvitations = await InvitationController.get(
      senderID: UserController.currentUser!.id,
      forceGet: true,
    ).first;
    setState(() {
      invitations = latestInvitations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Invite Requests"),
      endDrawer: CustomDrawer(pageContext: context),
      body: StreamBuilder<List<InvitationModel>>(
        stream: InvitationController.get(
          senderID: UserController.currentUser!.id,
        ),
        initialData: const [],
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              invitations = snapshot.data ?? [];
              if (invitations.isNotEmpty) {
                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 20.0),
                      child: Column(
                        children: invitations
                            .map((invitation) {
                              return InviteItem(
                                receiverID: invitation.recipientID,
                                clubPositionID: invitation.clubPositionID,
                                invitation: invitation,
                                onDeleteInvitation: _refresh,
                              );
                            })
                            .toList()
                            .separate(30),
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                showSnackBar(context, 'Error: ${snapshot.error}');
                throw Exception('Error: ${snapshot.error}');
              } else {
                return const Center(
                  child: Text(
                    "All your invitations sent appear here.\nNo invitations sent so far.",
                    textAlign: TextAlign.center,
                  ),
                );
              }
            } else {
              // Found to run when no user is logged in
              showSnackBar(context, "Please login");
              throw Exception("User not logged in");
            }
          } else {
            // Works for all connection state but the one encountered here is ConnectionState.waiting
            return const Center(child: CircularProgressIndicator());
          }
        },
        // ),
      ),
    );
  }
}
