import 'dart:io';

import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/services/user/user_controller.dart';
import 'package:efficacy_admin/pages/pages.dart';
import 'package:efficacy_admin/states/authenticator/authenticator.dart';
import 'package:efficacy_admin/widgets/profile_image_viewer/profile_image_viewer.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  File? _img;

  Widget imageView(String? s) {
    if (s != null) {
      _img = File(s);
      return ProfileImageViewer(
        enabled: false,
        image: _img,
      );
    }
    return const ProfileImageViewer(enabled: false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    //size constants
    double gap = height * 0.02;

    var route = ModalRoute.of(context);
    String? routeName;

    if (route != null) {
      debugPrint(route.settings.name);
      routeName = route.settings.name;
    }
    return Drawer(
      backgroundColor: light,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: dark),
            child: imageView(UserController.currentUser?.userPhoto),
          ),
          ListTile(
            title: const Text('Home'),
            selected: routeName == "/homePage",
            selectedColor: light,
            selectedTileColor: dark,
            onTap: () {
              // Close the drawer
              Navigator.pop(context);
              // Navigate to Home page
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Homepage.routeName, (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            title: const Text('Organizations'),
            selected: routeName == "/OrganizationsPage",
            selectedColor: light,
            selectedTileColor: dark,
            onTap: () {
              // Close the drawer
              Navigator.pop(context);
              // Navigate to Organizations page
              Navigator.of(context).pushNamedAndRemoveUntil(
                  OrganizationsPage.routeName, (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            title: const Text('Log out'),
            onTap: () {
              Authenticator.signOut();
              Navigator.pop(context);
            },
          ),
        ].separate(gap),
      ),
    );
  }
}
