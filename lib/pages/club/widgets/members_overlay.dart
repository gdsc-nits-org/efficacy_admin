import 'dart:math';

import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/models/models.dart';
import 'package:efficacy_admin/pages/club/widgets/confirm_remove_member.dart';
import 'package:flutter/material.dart';

class MembersOverlay extends StatefulWidget {
  final ClubModel? club;
  final ClubPositionModel clubPosition;

  const MembersOverlay(
      {super.key, required this.club, required this.clubPosition});

  @override
  State<MembersOverlay> createState() => _MembersOverlayState();
}

class _MembersOverlayState extends State<MembersOverlay> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<String> members = widget.club!.members[widget.clubPosition.id] ?? [];
    members = Set.of(members).toList();
    return SizedBox(
      width: min(400, size.width * .8),
      height: min(400 * 1.5, size.height * .8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 2),
            child: Column(
              children: [
                Text(
                  "${widget.clubPosition.position} Members",
                  style: const TextStyle(fontSize: 20, color: dark),
                ),
                Expanded(
                  child: members.isNotEmpty
                      ? ListView.builder(
                          itemCount: members.length,
                          itemBuilder: (context, index) {
                            String memberEmail = members[index];
                            return ListTile(
                              title: StreamBuilder(
                                stream: UserController.get(email: memberEmail),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: SizedBox(
                                        height: 15,
                                        width: 15,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    );
                                  } else {
                                    List<UserModel> user = snapshot.data ?? [];
                                    return Card(
                                      color: Colors.white,
                                      surfaceTintColor: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "${user.isNotEmpty ? user[0].name : ""}\n$memberEmail",
                                                maxLines: null,
                                              ),
                                            ),
                                            if (UserController
                                                .clubWithModifyMemberPermission
                                                .contains(widget.club))
                                              IconButton(
                                                onPressed: () async {
                                                  bool? didDelete =
                                                      await showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        ConfirmRemoveMember(
                                                      memberEmail: memberEmail,
                                                      member: user.isNotEmpty
                                                          ? user.first
                                                          : null,
                                                      clubPosition:
                                                          widget.clubPosition,
                                                    ),
                                                  );
                                                  if (didDelete == true) {
                                                    members.removeAt(index);
                                                  }
                                                },
                                                icon: const Icon(Icons.close),
                                              ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                              // Other details or actions related to the member
                            );
                          },
                        )
                      : const Center(
                          child: Text(
                            "No members",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
