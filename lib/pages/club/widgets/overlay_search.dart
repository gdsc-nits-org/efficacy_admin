import 'dart:math';

import 'package:efficacy_admin/models/models.dart';
import 'package:efficacy_admin/utils/tutorials/tutorials.dart';
import 'package:efficacy_admin/pages/club/widgets/invite_overlay.dart';
import 'package:efficacy_admin/utils/debouncer.dart';
import 'package:efficacy_admin/utils/local_database/local_database.dart';
import 'package:flutter/material.dart';

import 'package:efficacy_admin/controllers/controllers.dart';

class OverlaySearch extends StatefulWidget {
  final ClubModel? club;

  const OverlaySearch({super.key, required this.club});

  @override
  State<OverlaySearch> createState() => _OverlaySearchState();
}

class _OverlaySearchState extends State<OverlaySearch> {
  String? userName;
  Debouncer debouncer = Debouncer();
  List<UserModel> userList = [];
  Set<String> selectedUsers = {};
  bool isMultiSelect = false;
  bool memTutorialShown = false;

  // Global keys for guide
  GlobalKey searchUserKey = GlobalKey();
  GlobalKey memKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (LocalDatabase.getAndSetGuideStatus(LocalGuideCheck.inviteSearch)) {
      showSearchBarTutorial(context, searchUserKey);
    }
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
                Padding(
                  key: searchUserKey,
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

                        if (userList.isNotEmpty &&
                            LocalDatabase.getAndSetGuideStatus(
                                LocalGuideCheck.inviteUser)) {
                          showSelectUserTutorial(context, memKey);
                        }
                        // removes a user if userid is same as current user
                        userList.removeWhere((element) =>
                            element.id == UserController.currentUser?.id);
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
                                          key: (index == 0) ? memKey : null,
                                          title: Text(userList[index].name),
                                          subtitle: Text(userList[index].email),
                                          tileColor: selectedUsers
                                                  .contains(userList[index].id)
                                              ? Colors.green
                                              : null,
                                          onLongPress: () {
                                            setState(() {
                                              isMultiSelect = true;
                                              selectedUsers
                                                  .add(userList[index].id!);
                                            });
                                          },
                                          onTap: () {
                                            if (isMultiSelect) {
                                              setState(() {
                                                if (selectedUsers.contains(
                                                    userList[index].id)) {
                                                  selectedUsers.remove(
                                                      userList[index].id);
                                                  if (selectedUsers.isEmpty) {
                                                    isMultiSelect = false;
                                                  }
                                                } else {
                                                  selectedUsers
                                                      .add(userList[index].id!);
                                                }
                                              });
                                            } else {
                                              Navigator.pop(context);
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Center(
                                                      child: InviteOverlay(
                                                        inviteMode: true,
                                                        club: widget.club,
                                                        users: [
                                                          userList[index].id!
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            }
                                          },
                                        );
                                      }
                                      return null;
                                    },
                                  ),
                      );
                    }),
                isMultiSelect
                    ? ElevatedButton(
                        child: const Text("Continue"),
                        onPressed: () {
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Center(
                                  child: InviteOverlay(
                                    inviteMode: true,
                                    club: widget.club,
                                    users: selectedUsers.toList(),
                                  ),
                                );
                              });
                        },
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
