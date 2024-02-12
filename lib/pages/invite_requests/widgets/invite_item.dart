import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/dialogs/loading_overlay/loading_overlay.dart';
import 'package:efficacy_admin/models/invitation/invitaion_model.dart';
import 'package:efficacy_admin/models/models.dart';
import 'package:efficacy_admin/widgets/profile_image_viewer/profile_image_viewer.dart';
import 'package:efficacy_admin/widgets/snack_bar/error_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InviteItem extends StatefulWidget {
  final String clubPositionID;
  final String receiverID;
  final InvitationModel invitation;
  final Future<void> Function() onDeleteInvitation;
  // final VoidCallback onCompleteAcceptOrReject;
  const InviteItem({
    super.key,
    required this.clubPositionID,
    required this.receiverID,
    required this.invitation,
    required this.onDeleteInvitation,
    // required this.onCompleteAcceptOrReject,
  });

  @override
  State<InviteItem> createState() => _InviteItemState();
}

class _InviteItemState extends State<InviteItem> {
  @override
  Widget build(BuildContext context) {
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
              StreamBuilder<List<ClubPositionModel>>(
                stream: ClubPositionController.get(
                    clubPositionID: widget.clubPositionID),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  ClubPositionModel? clubPosition;
                  if (snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data.isNotEmpty) {
                    clubPosition = snapshot.data.first;
                  }
                  return StreamBuilder<List<ClubModel>>(
                    stream: clubPosition?.id != null
                        ? ClubController.get(id: clubPosition?.clubID)
                        : null,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      ClubModel? club;
                      if (snapshot.hasData &&
                          snapshot.data != null &&
                          snapshot.data.isNotEmpty) {
                        club = snapshot.data.first;
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (club?.clubLogoURL != null)
                                ProfileImageViewer(
                                  imagePath: club!.clubLogoURL,
                                  enabled: false,
                                  height: 20,
                                ),
                              Text(
                                club?.name ?? "Club",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ].separate(6),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Position: ",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              Text(
                                clubPosition?.position ?? "Position",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  );
                },
              ),
              StreamBuilder<List<UserModel>>(
                stream: UserController.get(id: widget.receiverID),
                builder: (BuildContext context,
                    AsyncSnapshot<List<UserModel>> snapshot) {
                  String receiverName = "Receiver";
                  String receiverMail = "";
                  if (snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data!.isNotEmpty) {
                    receiverName = snapshot.data!.first.name;
                    receiverMail = snapshot.data!.first.email;
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Receiver: ",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Text(
                        "${receiverName.split(" ").first}\n$receiverMail",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            height: 40,
            child: ElevatedButton(
              onPressed: () async {
                showLoadingOverlay(
                    context: context,
                    asyncTask: () async {
                      await InvitationController.delete(widget.invitation);
                      await widget.onDeleteInvitation();
                    });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                "Cancel request",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
