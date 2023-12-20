import 'dart:math';

import 'package:efficacy_admin/models/invitation/invitaion_model.dart';
import 'package:efficacy_admin/models/models.dart';
import 'package:efficacy_admin/pages/club/widgets/buttons.dart';
import 'package:efficacy_admin/utils/debouncer.dart';
import 'package:flutter/material.dart';

import 'package:efficacy_admin/controllers/controllers.dart';

class OverlaySearch extends StatefulWidget {
  const OverlaySearch({super.key});

  @override
  State<OverlaySearch> createState() => _OverlaySearchState();
}

class _OverlaySearchState extends State<OverlaySearch> {
  String? userName;
  Debouncer debouncer = Debouncer();
  List<UserModel> userList = [];
  List<UserModel> selectedUsers = [];
  bool isMultiSelect = false;

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
                  child: TextField(
                    onChanged: (String? name) {
                      debouncer.run(() {
                        setState(() {
                          userName = name;
                        });
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search users...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                isMultiSelect
                    ? Text("Selected: ${selectedUsers.length}")
                    : const Text(""),
                StreamBuilder<List<UserModel>>(
                    stream: UserController.get(nameStartsWith: userName),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        userList = snapshot.data ?? [];
                        if (userList.length == 1 &&
                            userList.first.id ==
                                UserController.currentUser?.id) {
                          userList = [];
                        }
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
                            : userList.isEmpty
                                ? const Center(
                                    child: Text(
                                    "No user found",
                                    style: TextStyle(color: Colors.black),
                                  ))
                                : ListView.builder(
                                    itemCount: userList.length,
                                    itemBuilder: (context, index) {
                                      if (userList[index].id !=
                                          UserController.currentUser?.id) {
                                        return ListTile(
                                          title: Text(userList[index].name),
                                          subtitle: Text(userList[index].email),
                                          tileColor: selectedUsers
                                                  .contains(userList[index])
                                              ? Colors.green
                                              : null,
                                          onLongPress: () {
                                            setState(() {
                                              isMultiSelect = true;
                                              selectedUsers
                                                  .add(userList[index]);
                                            });
                                          },
                                          onTap: () {
                                            if (isMultiSelect) {
                                              setState(() {
                                                if (selectedUsers.contains(
                                                    userList[index])) {
                                                  selectedUsers
                                                      .remove(userList[index]);
                                                  if (selectedUsers == []) {
                                                    isMultiSelect = false;
                                                  }
                                                } else {
                                                  selectedUsers
                                                      .add(userList[index]);
                                                }
                                              });
                                            } else {
                                              //invitation commented for now
                                              // InvitationController.create(
                                              //     InvitationModel(
                                              //         clubPositionID:
                                              //             UserController
                                              //                 .currentUser!
                                              //                 .position
                                              //                 .toString(),
                                              //         senderID: UserController
                                              //                 .currentUser!
                                              //                 .id ??
                                              //             "",
                                              //         recipientID:
                                              //             userList[index].id ??
                                              //                 ""));
                                            }
                                          },
                                        );
                                      }
                                      return null;
                                    },
                                  ),
                      );
                    }),
                InviteButton(
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
