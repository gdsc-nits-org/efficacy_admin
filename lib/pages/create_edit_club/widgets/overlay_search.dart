import 'package:efficacy_admin/models/invitation/invitaion_model.dart';
import 'package:efficacy_admin/models/models.dart';
import 'package:flutter/material.dart';

import '../../../controllers/controllers.dart';

class OverlaySearch extends StatefulWidget {
  const OverlaySearch({super.key});

  @override
  State<OverlaySearch> createState() => _OverlaySearchState();
}

class _OverlaySearchState extends State<OverlaySearch> {
  List<UserModel>? userList;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUsers("");
  }

  void getUsers(String nameStartsWith) {
    UserController.get(nameStartsWith: _searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                getUsers(value);
                setState(() {});
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
          Expanded(
            child: userList == null
                ? const Center(
                    child: Text(
                    "No user found",
                    style: TextStyle(color: Colors.black),
                  ))
                : ListView.builder(
                    itemCount: userList!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(userList![index].name),
                        subtitle: Text(userList![index].email),
                        onTap: () {
                          InvitationController.create(InvitationModel(
                              clubPositionID: UserController
                                  .currentUser!.position
                                  .toString(),
                              senderID: UserController.currentUser!.id ?? "",
                              recipientID: userList![index].id ?? ""));
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
