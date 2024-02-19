import 'dart:math';

import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/dialogs/loading_overlay/loading_overlay.dart';
import 'package:efficacy_admin/models/invitation/invitaion_model.dart';
import 'package:efficacy_admin/models/models.dart';
import 'package:efficacy_admin/pages/club/widgets/inivte_overlay/widgets/add_new_position_button.dart';
import 'package:efficacy_admin/utils/tutorials/tutorials.dart';
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
  final TextEditingController _newClubPositionController =
      TextEditingController();
  List<ClubPositionModel> clubPositionList = [];
  int selected = -1;

  // Global keys for guide
  GlobalKey newPosNameKey = GlobalKey();
  GlobalKey addKey = GlobalKey();
  GlobalKey posNameKey = GlobalKey();
  GlobalKey membersKey = GlobalKey();
  GlobalKey editPosKey = GlobalKey();
  GlobalKey inviteKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (LocalDatabase.getAndSetGuideStatus(LocalGuideCheck.editClubPosition)) {
      Future.delayed(const Duration(seconds: 1), () {
        showEditClubPosTutorial(
          context,
          newPosNameKey,
          addKey,
          posNameKey,
          membersKey,
          editPosKey,
          onFinish: () {
            if (widget.inviteMode &&
                LocalDatabase.getAndSetGuideStatus(
                    LocalGuideCheck.inviteButton)) {
              showInviteButtonTutorial(context, inviteKey);
            }
          },
        );
      });
    } else if (widget.inviteMode &&
        LocalDatabase.getAndSetGuideStatus(LocalGuideCheck.inviteButton)) {
      Future.delayed(const Duration(seconds: 1), () {
        showInviteButtonTutorial(context, inviteKey);
      });
    }
  }

  @override
  void dispose() {
    _newClubPositionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
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
                              key: newPosNameKey,
                              controller: _newClubPositionController,
                              label: "New club position",
                              prefixIcon: Icons.assignment_ind_outlined,
                            ),
                          ),
                          const Spacer(flex: 1),
                          Flexible(
                            key: addKey,
                            flex: 4,
                            child: SizedBox(
                                height: 40,
                                child: AddNewPositionButton(
                                  onTap: () async {
                                    if (_newClubPositionController
                                        .text.isNotEmpty) {
                                      String newClubPositionName =
                                          _newClubPositionController.text
                                              .trim();
                                      await showLoadingOverlay(
                                        parentContext: context,
                                        asyncTask: () async {
                                          ClubPositionModel? newClubPosition =
                                              await ClubPositionController
                                                  .create(
                                            ClubPositionModel(
                                              clubID: widget.club!.id!,
                                              position: newClubPositionName,
                                            ),
                                          );
                                          if (newClubPosition != null) {
                                            setState(() {});
                                          }

                                          if (mounted) {
                                            showSnackBar(
                                                context,
                                                newClubPosition != null
                                                    ? "$newClubPositionName position added to club"
                                                    : "Couldn't add position");
                                          }
                                        },
                                      );
                                    } else {
                                      showSnackBar(context,
                                          "Club position can't be empty");
                                    }
                                  },
                                  newClubPositionController:
                                      _newClubPositionController,
                                )),
                          ),
                        ],
                      ),
                    ),
                  StreamBuilder<List<ClubPositionModel>>(
                      stream:
                          ClubPositionController.get(clubID: widget.club!.id),
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
                                              key: (index == 0)
                                                  ? posNameKey
                                                  : null,
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
                                                  useRootNavigator: false,
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
                                              }
                                            });
                                          },
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                key: (index == 0)
                                                    ? membersKey
                                                    : null,
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    useRootNavigator: false,
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
                                                    key: (index == 0)
                                                        ? editPosKey
                                                        : null,
                                                    onPressed: () async {
                                                      var updatedPosition =
                                                          await showDialog(
                                                              context: context,
                                                              useRootNavigator:
                                                                  false,
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
                                                    icon:
                                                        const Icon(Icons.edit)),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                        );
                      }),
                  (widget.inviteMode)
                      ? ElevatedButton(
                          key: inviteKey,
                          onPressed: () async {
                            List<InvitationModel?> models = [];
                            await showLoadingOverlay(
                              parentContext: context,
                              asyncTask: () async {
                                if (selected == -1) {
                                  throw Exception("Please select a position");
                                }
                                for (String user in widget.users) {
                                  models.add(await InvitationController.create(
                                    InvitationModel(
                                      clubPositionID:
                                          clubPositionList[selected].id!,
                                      senderID: UserController.currentUser!.id!,
                                      recipientID: user,
                                    ),
                                  ));
                                }
                              },
                            );
                            if (models.length == widget.users.length &&
                                !models.contains(null)) {
                              if (mounted) {
                                Navigator.pop(context);
                                throw Exception(
                                    "Invitation sent successfully!");
                              }
                            }
                          },
                          child: const Text("Send Invite"))
                      : const SizedBox()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
