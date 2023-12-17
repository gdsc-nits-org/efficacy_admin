import 'package:efficacy_admin/models/models.dart';
import 'package:flutter/material.dart';

import '../../../controllers/controllers.dart';

class OverlaySearch extends StatefulWidget {
  const OverlaySearch({super.key});

  @override
  State<OverlaySearch> createState() => _OverlaySearchState();
}

class _OverlaySearchState extends State<OverlaySearch> {
  List<UserModel> ? userList;
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
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                getUsers(value);
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Search users...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: userList == null
                ? Center(
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
                        onTap: () {},//invite user logic to be added later
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
