import 'package:efficacy_admin/controllers/services/invitation/invitation_controller.dart';
import 'package:efficacy_admin/controllers/services/user/user_controller.dart';
import 'package:efficacy_admin/models/invitation/invitaion_model.dart';
import 'package:efficacy_admin/pages/organizations_page/widgets/invitations/invitations_item.dart';
import 'package:efficacy_admin/widgets/snack_bar/error_snack_bar.dart';
import 'package:flutter/material.dart';

class InvitationsStream extends StatefulWidget {
  final double maxHeight;
  final VoidCallback onCompleteAction;

  const InvitationsStream({
    super.key,
    required this.maxHeight,
    required this.onCompleteAction,
  });

  @override
  State<InvitationsStream> createState() => InvitationsStreamState();
}

class InvitationsStreamState extends State<InvitationsStream> {
  late Stream<List<InvitationModel>> invitations;

  @override
  void initState() {
    super.initState();
    invitations = _getInvitations();
  }

  Stream<List<InvitationModel>> _getInvitations() {
    return InvitationController.get(
      recipientID: UserController.currentUser?.id,
    );
  }

  Future<void> refreshInvites() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      invitations = _getInvitations();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: widget.maxHeight),
      child: StreamBuilder<List<InvitationModel>>(
        stream: _getInvitations(),
        initialData: const [],
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final invitations = snapshot.data;
              if (invitations!.isNotEmpty) {
                return SingleChildScrollView(
                  child: Column(
                    children: invitations.map((invitation) {
                      return InvitationItem(
                        senderID: invitation.senderID,
                        clubPositionID: invitation.clubPositionID,
                        invitation: invitation,
                        onCompleteAcceptOrReject: () {
                          widget.onCompleteAction();
                        },
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
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
