import 'package:efficacy_admin/pages/profile_page/widgets/confirm_delete_profile.dart';
import 'package:efficacy_admin/widgets/snack_bar/error_snack_bar.dart';
import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  final void Function() onPressed;

  const EditButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    //size constants
    double fontSize = 30;
    double pad = 18.0;
    return Padding(
      padding: EdgeInsets.all(pad),
      child: IconButton(
          tooltip: "Edit Profile",
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.transparent)),
          onPressed: onPressed,
          icon: Icon(
            Icons.edit,
            size: fontSize,
            color: Colors.black,
          )),
    );
  }
}

class SaveButton extends StatelessWidget {
  final void Function() onPressed;

  const SaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    //screen size
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    //size constants
    double buttonWidth = width * 0.28;
    double buttonHeight = height * 0.06;
    double fontSize = 18;
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: FloatingActionButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.save,
              size: fontSize,
            ),
            Text(
              "Save",
              style: TextStyle(fontSize: fontSize),
            ),
          ],
        ),
      ),
    );
  }
}

class DeleteProfileButton extends StatelessWidget {
  const DeleteProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    double fontSize = 20;
    double pad = 18.0;
    return Padding(
      padding: EdgeInsets.all(pad),
      child: ElevatedButton(
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.red)),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => const ConfirmDelProfile(),
          );
        },
        child: Text(
          "Delete Profile",
          style: TextStyle(fontSize: fontSize),
        ),
      ),
    );
  }
}
