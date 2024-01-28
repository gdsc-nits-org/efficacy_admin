import 'dart:math';

import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/dialogs/loading_overlay/loading_overlay.dart';
import 'package:efficacy_admin/models/invitation/invitaion_model.dart';
import 'package:efficacy_admin/models/models.dart';
import 'package:efficacy_admin/pages/club/utils/invite_members_tutorial.dart';
import 'package:efficacy_admin/pages/club/widgets/members_overlay.dart';
import 'package:efficacy_admin/pages/club/widgets/position_permission_overlay.dart';
import 'package:efficacy_admin/utils/local_database/local_database.dart';
import 'package:efficacy_admin/widgets/custom_text_field/custom_text_field.dart';
import 'package:efficacy_admin/widgets/snack_bar/error_snack_bar.dart';
import 'package:flutter/material.dart';

class InviteOverlay extends StatefulWidget {
  final List<String> users;
  final ClubModel? club;
  final bool inviteMode;
  const InviteOverlay({
    super.key,
    required this.inviteMode,
    required this.club,
    this.users = const [],
  });

  @override
  State<InviteOverlay> createState() => _InviteOverlayState();
}

class _InviteOverlayState extends State<InviteOverlay> {
  final TextEditingController _newClubPosition = TextEditingController();
  List<ClubPositionModel> clubPositionList = [];
  String _newClubPositionName = '';
  int selected = -1;
  @override
  void initState() {
    super.initState();
    _newClubPosition.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    _newClubPositionName = _newClubPosition.text.trim();
  }

  @override
  void dispose() {
    _newClubPosition.dispose();
    super.dispose();
  }

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
                if (UserController.clubWithModifyClubPermission
                    .contains(widget.club))
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 8,
                          child: CustomTextField(
                            controller: _newClubPosition,
                            label: "New club position",
                            prefixIcon: Icons.assignment_ind_outlined,
                          ),
                        ),
                        const Spacer(flex: 1),
                        Flexible(
                          flex: 4,
                          child: SizedBox(
                            height: 40,
                            child: _newClubPositionName.isNotEmpty
                                ? ElevatedButton(
                                    onPressed: () async {
                                      await showLoadingOverlay(
                                        context: context,
                                        asyncTask: () async {
                                          ClubPositionModel? newClubPosition =
                                              await ClubPositionController
                                                  .create(
                                            ClubPositionModel(
                                              clubID: widget.club!.id!,
                                              position: _newClubPositionName,
                                            ),
                                          );
                                          if (newClubPosition != null) {
                                            setState(() {});
                                          }

                                          if (mounted) {
                                            showErrorSnackBar(
                                                context,
                                                newClubPosition != null
                                                    ? "$_newClubPositionName position added to club"
                                                    : "Couldn't add position");
                                          }
                                        },
                                      );
                                    },
                                    child: const Text("Add"),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      showErrorSnackBar(context,
                                          "Club position can't be empty");
                                    },
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(shadow)),
                                    child: const Text("Add")),
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
                                            if (widget.inviteMode) {
                                              if (selected == index) {
                                                selected = -1;
                                              } else {
                                                selected = index;
                                              }
                                            } else {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Center(
                                                      child: MembersOverlay(
                                                    club: widget.club,
                                                    clubPosition:
                                                        clubPositionList[index],
                                                  ));
                                                },
                                              );
                                            }
                                          });
                                        },
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Center(
                                                        child: MembersOverlay(
                                                      club: widget.club,
                                                      clubPosition:
                                                          clubPositionList[
                                                              index],
                                                    ));
                                                  },
                                                );
                                              },
                                              icon: const Icon(Icons.group),
                                            ),
                                            if (UserController
                                                .clubWithModifyClubPermission
                                                .contains(widget.club))
                                              IconButton(
                                                  onPressed: () async {
                                                    var updatedPosition =
                                                        await showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return Center(
                                                                child:
                                                                    ClubPositionPermissionOverlay(
                                                                  clubPosition:
                                                                      clubPositionList[
                                                                          index],
                                                                ),
                                                              );
                                                            });
                                                    if (updatedPosition !=
                                                            null &&
                                                        updatedPosition
                                                            is ClubPositionModel) {
                                                      setState(() {
                                                        clubPositionList[
                                                                index] =
                                                            updatedPosition;
                                                      });
                                                    }
                                                    if (updatedPosition ==
                                                        null) {
                                                      setState(() {
                                                        clubPositionList
                                                            .removeAt(index);
                                                      });
                                                    }
                                                  },
                                                  icon: const Icon(Icons.edit)),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                      );
                    }),
                (widget.inviteMode)
                    ? ElevatedButton(
                        onPressed: () {
                          showLoadingOverlay(
                            context: context,
                            asyncTask: () async {
                              for (String user in widget.users) {
                                await InvitationController.create(
                                  InvitationModel(
                                      clubPositionID:
                                          clubPositionList[selected].id!,
                                      senderID:
                                          UserController.currentUser!.id ?? "",
                                      recipientID: user),
                                );
                              }
                              if (mounted) {
                                showErrorSnackBar(
                                    context, "Invitation sent successfully!");
                                Navigator.pop(context);
                              }
                            },
                          );
                        },
                        child: const Text("Send Invite"))
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
