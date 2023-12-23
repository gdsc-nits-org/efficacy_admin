import 'dart:math';

import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/models/invitation/invitaion_model.dart';
import 'package:efficacy_admin/models/models.dart';
import 'package:efficacy_admin/widgets/custom_text_field/custom_text_field.dart';
import 'package:efficacy_admin/widgets/snack_bar/error_snack_bar.dart';
import 'package:flutter/material.dart';

class InviteOverlay extends StatefulWidget {
  final List<UserModel> users;
  final ClubModel? club;
  const InviteOverlay({
    super.key,
    required this.club,
    this.users = const [],
  });

  @override
  State<InviteOverlay> createState() => _InviteOverlayState();
}

class _InviteOverlayState extends State<InviteOverlay> {
  final TextEditingController _newClub = TextEditingController();
  List<ClubPositionModel> clubPositionList = [];
  int selected = -1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: min(400, size.width * .8),
      height: min(400 * 1.5, size.height * .8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 8,
                        child: CustomTextField(
                          controller: _newClub,
                          label: "New club position",
                          prefixIcon: Icons.assignment_ind_outlined,
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Flexible(
                        flex: 4,
                        child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                ClubPositionController.create(ClubPositionModel(
                                    clubID: widget.club!.id!,
                                    position: _newClub.text.toString()));
                              });
                              showErrorSnackBar(context,
                                  "${_newClub.text.toString()} position added to club");
                            },
                            child: const Text("Add"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<List<ClubPositionModel>>(
                    stream: ClubPositionController.get(clubID: widget.club!.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        clubPositionList = snapshot.data ?? [];
                      }
                      return Expanded(
                        child: snapshot.connectionState ==
                                ConnectionState.waiting
                            ? const Center(
                                child: SizedBox(
                                  height: 45,
                                  width: 45,
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : clubPositionList.isEmpty
                                ? const Center(
                                    child: Text(
                                    "No position found in club",
                                    style: TextStyle(color: Colors.black),
                                  ))
                                : ListView.builder(
                                    itemCount: clubPositionList.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        selected: index == selected,
                                        selectedTileColor: paleBlue,
                                        title: Text(
                                            clubPositionList[index].position),
                                        onTap: () {
                                          setState(() {
                                            selected = index;
                                          });
                                        },
                                      );
                                    },
                                  ),
                      );
                    }),
                ElevatedButton(
                    onPressed: () {
                      for (UserModel user in widget.users) {
                        InvitationController.create(InvitationModel(
                            clubPositionID: clubPositionList[selected].clubID,
                            senderID: UserController.currentUser!.id ?? "",
                            recipientID: user.id!));
                      }
                      showErrorSnackBar(
                          context, "Invitation sent successfully!");
                      Navigator.pop(context);
                    },
                    child: const Text("Send Invite"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
