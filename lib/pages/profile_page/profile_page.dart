import 'dart:io';
import 'package:efficacy_admin/controllers/services/user/user_controller.dart';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/models/models.dart';
import 'package:efficacy_admin/pages/profile_page/widgets/buttons.dart';
import 'package:efficacy_admin/widgets/custom_drop_down/custom_drop_down.dart';
import 'package:efficacy_admin/widgets/custom_phone_input/custom_phone_input.dart';
import 'package:efficacy_admin/widgets/custom_text_field/custom_text_field.dart';
import 'package:efficacy_admin/widgets/profile_image_viewer/profile_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:efficacy_admin/config/config.dart';
import 'package:gap/gap.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/ProfilePage';

  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  File? _img;
  bool editMode = false;
  bool showButton = false;

  void enableEdit() {
    setState(() {
      editMode = true;
      showButton = true;
    });
  }

  void saveUpdates(){
    setState(() {
      editMode = false;
      showButton = false;
    });
  }

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
    //screen size
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    //size constants
    double gap = height * 0.02;
    double hMargin = width * 0.08;
    double vMargin = width * 0.16;

    return Scaffold(
      floatingActionButton: Visibility(
        visible: showButton,
        child:SaveButton(
          onPressed: saveUpdates,
        ) ,),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.symmetric(vertical: vMargin, horizontal: hMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Account Details",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Gap(gap),

                imageView(UserController.currentUser?.userPhoto),
                //edit button
                EditButton(
                  onPressed: () => enableEdit(),
                ),

                CustomTextField(
                  title: "Name",
                  enabled: editMode ? true : false,
                  initialValue: UserController.currentUser?.name,
                ),
                CustomPhoneField(
                  title: "Phone",
                  enabled: editMode ? true : false,
                  initialValue: UserController.currentUser?.phoneNumber,
                ),
                CustomTextField(
                  title: "ScholarID",
                  enabled: editMode ? true : false,
                  initialValue: UserController.currentUser?.scholarID,
                ),
                CustomDropDown(
                  title: "Branch",
                  items: Branch.values.map((branch) => branch.name).toList(),
                  enabled: editMode ? true : false,
                  initialValue: UserController.currentUser?.branch.name,
                ),
                CustomDropDown(
                  title: "Degree",
                  items: Degree.values.map((degree) => degree.name).toList(),
                  enabled: editMode ? true : false,
                  initialValue: UserController.currentUser?.degree.name,
                ),
                // CustomDataTable(
                //   columnspace: width*0.35,
                //   columns: const ["ClubId", "Position"],
                //   rows: (UserController.currentUser?.position)??const [],
                // )
              ].separate(gap),
            ),
          ),
        ),
      ),
    );
  }
}
