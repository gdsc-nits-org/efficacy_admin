import 'dart:io';
import 'package:efficacy_admin/controllers/services/user/user_controller.dart';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/models/models.dart';
import 'package:efficacy_admin/widgets/custom_data_table/custom_data_table.dart';
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
  static String? imgPath = UserController.currentUser?.userPhoto;
  final File _img = File(imgPath!);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    //size constants
    double gap = height * 0.02;
    double hmargin = width * 0.08;
    double vmargin = width * 0.16;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: vmargin, horizontal: hmargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Account Details",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Gap(gap),
                ProfileImageViewer(
                  image: _img,
                ),
                CustomTextField(
                  title: "Name",
                  enabled: false,
                  initialValue: UserController.currentUser?.name,
                ),
                CustomPhoneField(
                  title: "Phone",
                  enabled: false,
                  initialValue: UserController.currentUser?.phoneNumber,
                ),
                CustomTextField(
                  title: "ScholarID",
                  enabled: false,
                  initialValue: UserController.currentUser?.scholarID,
                ),
                CustomDropDown(
                  title: "Branch",
                  items: Branch.values.map((branch) => branch.name).toList(),
                  enabled: false,
                  initialValue: UserController.currentUser?.branch.name,
                ),
                CustomDropDown(
                  title: "Degree",
                  items: Degree.values.map((degree) => degree.name).toList(),
                  enabled: false,
                  initialValue: UserController.currentUser?.degree.name,
                ),
                // ...(Authenticator.currentUser?.position ?? [])
                //     .map(
                //       (position) => CustomTextField(
                //         initialValue: position.,
                //       ),
                //     )
                //     .toList()
                CustomDataTable(
                  columnspace: width*0.5,
                  columns: const ["ClubId", "Position"],
                  rows: (UserController.currentUser?.position)!,
                )
              ].separate(gap),
            ),
          ),
        ),
      ),
    );
  }
}
